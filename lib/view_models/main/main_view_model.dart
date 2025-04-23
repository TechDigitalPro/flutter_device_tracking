import 'dart:async';

import 'package:device_tracking/model/common/device_status.dart';
import 'package:device_tracking/utils/string_utils.dart';
import 'package:device_tracking/utils/widget_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as blue;
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../model/common/device_model.dart';
import '../../model/common/home_data.dart';
import '../../views/auth/login_view.dart';
import '../../views/main/bluetooth_pair_view.dart';
import '../base_view_model.dart';
import 'package:permission_handler/permission_handler.dart';

class MainViewModel extends BaseViewModel with WidgetsBindingObserver {
  List<DeviceModel> mList = [];
  bool isBluetooth = false;
  bool isDiscovering = false;
  StreamSubscription<BluetoothDiscoveryResult>? streamSubscription;

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

    HomeData? homeData = await sharedService.getHomeData();
    if (homeData != null) {
      mList = homeData.deviceList ?? [];
      for (var device in mList) {
        device.status = DeviceStatus.disconnected;
      }
      if (isBluetooth) {
        if (context.mounted) {
          onClickScan(context);
        }
      }
    } 

    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  initUI(BuildContext context) {}

  onClickLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((_) {
      if (context.mounted) {
        LoginView().launch(context, isNewTask: true);
      }
    });
  }

  onClickProfile(BuildContext context) {}

  onClickBluetooth(BuildContext context) async {
    bool? result = await const BluetoothPairView().launch(context);
    isBluetooth = await FlutterBluetoothSerial.instance.isEnabled ?? false;

    if (result != null && result) {
      if (context.mounted) {
        initialize(context);
      }
    }

    notifyListeners();
  }

  onClickDelete(BuildContext context, DeviceModel item) async {
    if (isDiscovering) {
      streamSubscription!.pause();
      isDiscovering = false;
      notifyListeners();
    }

    HomeData? data = await sharedService.getHomeData();
    if (data != null) {
      bool alreadyExists = data.deviceList!.any((d) => d.id == item.id);
      if (alreadyExists) {
        data.deviceList!.removeWhere((element) => element.id == item.id);
        mList.remove(item);
        sharedService.saveHomeData(data);
        notifyListeners();
      }
    }
  }
  
  onClickScan(BuildContext context) async {
    List<BluetoothDevice> mBondList = [];
    mBondList = await FlutterBluetoothSerial.instance.getBondedDevices();
      for(int i = 0; i < mBondList.length; i++){
        final existingIndex = mList.indexWhere((element) =>
            element.id == mBondList[i].address);
        if (existingIndex >= 0) {
          mList[existingIndex].status = DeviceStatus.connected;
        }
        notifyListeners();
      }

      streamSubscription = FlutterBluetoothSerial.instance
          .startDiscovery()
          .listen((discoveryResult) {
        final existingIndex = mList.indexWhere((element) =>
            element.id == discoveryResult.device.address);
        if (existingIndex >= 0) {
          mList[existingIndex].status = DeviceStatus.connected;
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
  }
}
