
import 'package:device_tracking/extentions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/main/bluetooth_pair_view_model.dart';
import '../items/item_bluetooth_paired_device_view.dart';

class BluetoothPairView extends StatefulWidget {
  const BluetoothPairView({
    super.key
    });

  @override
  State<BluetoothPairView> createState() => _BluetoothPairViewState();
}

class _BluetoothPairViewState extends State<BluetoothPairView> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BluetoothPairViewModel>.reactive(
      viewModelBuilder: () => BluetoothPairViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  //
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  buildWidget(BuildContext context, BluetoothPairViewModel model, Widget? child) {
    var width = MediaQuery.of(context).size.width;
    setStatusBarColor(ColorUtils.appColorPrimaryDark);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, details) async {
        if (result) return;
      },
        child: Scaffold(
            backgroundColor: ColorUtils.appColorPrimaryDark,
            appBar: AppBar(
              backgroundColor: ColorUtils.appColorPrimaryDark,
              title: textView(
                StringUtils.txtBluetooth,
                textColor: ColorUtils.appColorWhite,
                fontSize: SizeUtils.textSizeXLarge,
                fontWeight: FontWeight.bold,
              ),
              leading: IconButton(
                onPressed: () {
                  model.onClickBack(context);
                },
                icon: Icon(Icons.arrow_back, color: ColorUtils.appColorWhite),
              ),
            ),
            body: SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.05, width * 0.01, width * 0.05, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: textView(StringUtils.txtBluetooth,
                                textColor: ColorUtils.appColorWhite,
                                fontSize: SizeUtils.textSizeNormal),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                              splashRadius: 24,
                              onPressed: () {
                                model.onClickBleSetting(context);
                              },
                              icon: Icon(Icons.settings_outlined, color: ColorUtils.appColorWhite, size: 24)),
                            Switch(
                              activeColor: ColorUtils.appColorGreen,
                              inactiveTrackColor: ColorUtils.appColorPrimary,
                              value: model.isBluetooth, 
                              onChanged: (value){
                                model.onChangeStatus(value);
                              }),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: textView(StringUtils.txtBluetoothDevicesFound,
                                textColor: ColorUtils.appColorWhite,
                                fontSize: SizeUtils.textSizeMedium),
                            ),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: ColorUtils.appColorWhite,
                                strokeWidth: 1,
                              ),
                            ).visible(model.isDiscovering),
                            Container(
                              alignment: Alignment.center,
                              child: RoundButton(
                                isStroked: true,
                                padding: const EdgeInsets.all(0),
                                textContent: 
                                (model.isDiscovering)
                                ? StringUtils.txtStop
                                : StringUtils.txtScan,
                                textSize: SizeUtils.textSizeSMedium,
                                strokeColor: ColorUtils.appColorWhite_20,
                                radius: 5,
                                onPressed: () {
                                  model.onClickScan(
                                    context,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ).visible(model.isBluetooth),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: <Widget>[
                                  ListView(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    children: getChildList(context, model),
                                  ),
                                ],
                              ),
                            ),
                          ).visible(model.isBluetooth),
                    ]
                  ),
                ),
              )
              
            ),
    );
  }

  List<Widget> getChildList(BuildContext context, BluetoothPairViewModel model) {
    return model.discoveryResultList.map((item) {
      final device = item;
      final address = device.address;
      
      return ItemBluetoothPairedDeviceView(
        title: device.name ?? '',
        address: address,
        device: device,
        onItemClicked: (){
          model.onDeviceClicked(context, item);
        },
        onClickConnect: (){
          model.onClickConnect(context, item);
        },
      );
    }).toList();
  }
}
