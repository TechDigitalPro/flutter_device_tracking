import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_tracking/model/common/device_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as blue;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/common/device_model.dart';
import '../../model/common/home_data.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/dialog/edit_text_dlg.dart';
import '../base_view_model.dart';

class BluetoothPairViewModel extends BaseViewModel with WidgetsBindingObserver {
  bool isBluetooth = false;
  StreamSubscription<BluetoothDiscoveryResult>? streamSubscription;
  List<BluetoothDevice> discoveryResultList = [];
  List<BluetoothDevice> mBondList = [];
  bool isDiscovering = false;

  BluetoothConnection? connection;
  bool isConnecting = true;
  bool isDisconnecting = false;
  String messageBuffer = '';

  blue.FlutterBluePlus? flutterBlue;
  // StreamSubscription<List<blue.ScanResult>>? streamBlue;
  //List<blue.BluetoothDevice> mBondList = [];
  List<blue.BluetoothDevice> mConnectedList = [];
  blue.BluetoothDevice? curBluetoothDevice;

  FlutterReactiveBle flutterReactiveBle = FlutterReactiveBle();

  initialize(BuildContext context) async {
    
    if (!await Permission.location.isGranted) {
      await Permission.location.request();
    }
    var status = await [
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
    ].request();

    if(status.values.any((element) => element.isDenied)){
      showMessage(StringUtils.txtPleaseEnableAllPermissions, null);
      return;
    }
    if (await blue.FlutterBluePlus.isSupported == false) {
      showMessage(StringUtils.txtBluetoothNotSupportedByThisDevice, null);
    } else {
      isBluetooth = await FlutterBluetoothSerial.instance.isEnabled ?? false;
    }
    
    if (isBluetooth) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) => {
        if (context.mounted) {
          onClickScan(context),
        }
      });
    }

    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    try {
      FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
      streamSubscription?.cancel();
      // streamBlue?.cancel();
    } catch (e) {
      debugPrint(e.toString());
    }
    super.dispose();
  }

  onChangeStatus(bool status) async {
    if (isBluetooth == status) return;

    if (status) {
      final result = await FlutterBluetoothSerial.instance.requestEnable();
      isBluetooth = result ?? false;
    } else {
      final result = await FlutterBluetoothSerial.instance.requestDisable();
      isBluetooth = !(result ?? true);
      discoveryResultList.clear();
    }

    notifyListeners();
  }

  onClickBleSetting(BuildContext context) {
    FlutterBluetoothSerial.instance.openSettings();
  }

  onClickScan(BuildContext context) async {
    if (!isBluetooth) {
      showMessage(StringUtils.txtPleaseEnableBluetooth, null);
      return;
    }
    if (isDiscovering) {
      streamSubscription!.pause();
      // streamBlue?.pause();
      isDiscovering = false;
      notifyListeners();
    } else {
      isDiscovering = true;
      discoveryResultList.clear();
      notifyListeners();

      mBondList = await FlutterBluetoothSerial.instance.getBondedDevices();
      for(int i = 0; i < mBondList.length; i++){
        final existingIndex = discoveryResultList.indexWhere((element) =>
            element.address == mBondList[i].address);
        if (mBondList[i].name != null &&
            mBondList[i].name!.isNotEmpty) {
          if (existingIndex >= 0) {
            discoveryResultList[existingIndex] = mBondList[i];
          } else {
            discoveryResultList.add(mBondList[i]);
          }
          if(mBondList[i].isConnected){
            discoverServices(mBondList[i].address, mBondList[i].name);
          }
        }
      }

      streamSubscription = FlutterBluetoothSerial.instance
          .startDiscovery()
          .listen((discoveryResult) {
        final existingIndex = discoveryResultList.indexWhere((element) =>
            element.address == discoveryResult.device.address);
        if (discoveryResult.device.name != null &&
            discoveryResult.device.name!.isNotEmpty) {
          if (existingIndex >= 0) {
            discoveryResultList[existingIndex] = discoveryResult.device;
          } else {
            discoveryResultList.add(discoveryResult.device);
          }
        }

        notifyListeners();
      });
      

      streamSubscription!.onDone(() {
        isDiscovering = false;
        notifyListeners();
      });
      streamSubscription!.onError((_) {
        isDiscovering = false;
        notifyListeners();
      });
      // streamBlue = blue.FlutterBluePlus.onScanResults.listen((results) {
      //       if (results.isNotEmpty) {
      //         for (int i = 0; i < results.length; i++) {
      //           blue.ScanResult result = results[i];
      //           final existingIndex = discoveryResultList.indexWhere((element) =>
      //           element.address == result.device.remoteId.str);
      //           if (result.device.advName.isNotEmpty) {
      //             if (existingIndex >= 0) {
      //               discoveryResultList[existingIndex] = 
      //               BluetoothDevice(
      //                 name: result.device.advName,
      //                 address: result.device.remoteId.str,
      //               );
      //             } else {
      //               discoveryResultList.add(
      //                 BluetoothDevice(
      //                 name: result.device.advName,
      //                 address: result.device.remoteId.str,
      //               )
      //               );
      //             }
      //           }
      //         }

      //         notifyListeners();
      //       }
      //     },
      //     onDone: () {
      //       isDiscovering = false;
      //       notifyListeners();
      //     },
      //     onError: (e) {
      //       isDiscovering = false;
      //       notifyListeners();
      //     },
      // );
      // blue.FlutterBluePlus.cancelWhenScanComplete(streamBlue!);
      // blue.FlutterBluePlus.startScan();
      // await Future.delayed(const Duration(seconds: 5)).then((_) async {
      //   await blue.FlutterBluePlus.stopScan();
      //   isDiscovering = false;
      //   notifyListeners();
      // });
      
    }
  }

  onDeviceClicked(
      BuildContext context, BluetoothDevice discoveryResult) async {
        if(isDiscovering) {
          showMessage(StringUtils.txtAppIsScanningDevices, null);
          return;
        }
    try {
      if (discoveryResult.isConnected) {
        showMessage(StringUtils.txtThisDeviceIsAlreadyConnected, null);
        onClickAddDevice(context, discoveryResult);
        return;
      }
      bool bonded = false;
      if (discoveryResult.isBonded) {
        showMessage(StringUtils.txtThisDeviceIsAlreadyPaired, null);
        return;
      } else {
        showLoading();
        bonded = await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(discoveryResult.address) ?? false;
        // await FlutterBluetoothSerial.instance
        //     .bondDeviceAtAddress(discoveryResult.address).then((value) {
        //       bonded = value ?? false;
        //     });
        await Future.delayed(Duration(seconds: 2));
        hideLoading();
        if (context.mounted) {
          onClickScan(context);
        }
      }
      discoveryResultList[discoveryResultList.indexOf(discoveryResult)] =
          BluetoothDevice(
          name: discoveryResult.name ?? '',
          address: discoveryResult.address,
          type: discoveryResult.type,
          bondState:
              bonded ? BluetoothBondState.bonded : BluetoothBondState.none,
        );

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      showMessage(StringUtils.txtErrorOccurredWhileBonding, null);
    }
  }

  onClickConnect(BuildContext context, BluetoothDevice item) async {
    if(isDiscovering) {
          showMessage(StringUtils.txtAppIsScanningDevices, null);
          return;
        }
    if(item.isConnected){
      showMessage(StringUtils.txtPleaseDisableAndEnableAgain, null);
      return;
    }else {
      showLoading();
      flutterReactiveBle
            .connectToDevice(id: item.address)
            .listen((event) {
              hideLoading();
          if (event.connectionState == DeviceConnectionState.connected) {
            discoveryResultList[discoveryResultList.indexOf(item)] =
                BluetoothDevice(
                name: item.name ?? '',
                address: item.address,
                type: item.type,
                isConnected: true,
              );

            notifyListeners();
            discoverServices(item.address, item.name);
          } else if(event.connectionState == DeviceConnectionState.disconnected){
            discoveryResultList[discoveryResultList.indexOf(item)] =
                BluetoothDevice(
                name: item.name ?? '',
                address: item.address,
                type: item.type,
                isConnected: false,
              );
            
            showMessage(StringUtils.txtBleDeviceDisconnected, null);
          } else if(event.connectionState == DeviceConnectionState.connecting) {
            showMessage(StringUtils.txtBleDeviceConnecting, null);
            notifyListeners();
          }
        })
        .onError((_){
          hideLoading();
          showMessage(StringUtils.txtErrorOccurredWhileConnecting, null);
        });
    }
  }

  onTryReconnect(BluetoothDiscoveryResult item) {
    BluetoothConnection.toAddress(item.device.address).then((bleConnection) {
      debugPrint('Connected to the device');
      connection = bleConnection;
      isConnecting = false;
      isDisconnecting = false;

      connection!.input!.listen(onDataReceived).onDone(() {
        if (isDisconnecting) {
          debugPrint('Disconnecting locally!');
        } else {
          debugPrint('Disconnected remotely!');
        }
      });

      notifyListeners();
    }).catchError((error) {
      showMessage('Cannot connect, exception occurred', null);
      debugPrint(error.toString());
    });
  }

  onDataReceived(Uint8List data) {
    int backspacesCounter = 0;
    for (var byte in data) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    }
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    if (~index != 0) {
      messageBuffer = (backspacesCounter > 0
          ? messageBuffer.substring(0, messageBuffer.length - backspacesCounter)
          : messageBuffer + dataString.substring(0, index));
      messageBuffer = dataString.substring(index);
    } else {
      messageBuffer = (backspacesCounter > 0
          ? messageBuffer.substring(0, messageBuffer.length - backspacesCounter)
          : messageBuffer + dataString);
    }

    debugPrint(dataString);
  }

  discoverServices(String deviceId, String? name) async {
    // showLoading();
    // try {
    //   List<DiscoveredService> serviceList =
    //       await flutterReactiveBle.discoverServices(deviceId);
    //   for (int i = 0; i < serviceList.length; i++) {
        
    //   }
    //   hideLoading();
    // } catch (e) {
    //   hideLoading();
    //   debugPrint(e.toString());
    // }
  }

  onClickBack(BuildContext context) {
    finishView(context);
  }
  
  onClickAddDevice(BuildContext context, BluetoothDevice discoveryResult) {
    showDialog(
      context: context,
      builder: (BuildContext dlgContext) => EditTextDlg(
        title: StringUtils.txtDescription,
        hint: StringUtils.txtDescription,
        name: discoveryResult.name ?? '',
        onClickSave: (String text){
          DeviceModel deviceModel = DeviceModel();
          deviceModel.id = discoveryResult.address;
          deviceModel.name = discoveryResult.name;
          deviceModel.description = text;
          deviceModel.status = DeviceStatus.connected;
          deviceModel.created = Timestamp.fromDate(DateTime.now());

          onAddDeviceToHome(context, deviceModel);
        },
      )
    );
    

  }
  
  onAddDeviceToHome(BuildContext context, DeviceModel deviceModel) async {
    HomeData? data = await sharedService.getHomeData();
    if (data == null) {
      data = HomeData();
      data.deviceList = [];
      data.deviceList!.add(deviceModel);
    } else {
      data.deviceList ??= [];
      bool alreadyExists = data.deviceList!.any((d) => d.id == deviceModel.id);
      if (!alreadyExists) {
        data.deviceList!.insert(0, deviceModel);
      } else {
        showMessage(StringUtils.txtDeviceIsAlreadyAdded, null);
        return;
      }
    }

    sharedService.saveHomeData(data);
    if (context.mounted) {
      finishView(context, true);
    }
  }
}
