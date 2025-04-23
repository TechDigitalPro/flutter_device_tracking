import 'package:device_tracking/extentions/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class ItemBluetoothPairedDeviceView extends StatefulWidget {
  ItemBluetoothPairedDeviceView({
    super.key,
    required this.title,
    required this.address,
    required this.device,
    this.onItemClicked,
    this.onClickConnect,
  });

  final String title;
  final String address;
  final BluetoothDevice device;
  Function? onItemClicked;
  Function? onClickConnect;

  @override
  State<StatefulWidget> createState() => _ItemBluetoothPairedDeviceViewState();
}

class _ItemBluetoothPairedDeviceViewState
    extends State<ItemBluetoothPairedDeviceView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.onItemClicked != null) {
            widget.onItemClicked!();
          }
        },
        child: Column(
          children: <Widget>[
            Container(
                color: ColorUtils.appColorTransparent,
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: Icon(Icons.bluetooth_outlined,
                          color: widget.device.isBonded ||
                                  widget.device.isConnected
                              ? ColorUtils.appColorGreen
                              : ColorUtils.appColorWhite_50),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              child: textView(widget.title,
                                  fontSize: SizeUtils.textSizeLargeMedium,
                                  textColor: ColorUtils.appColorWhite)),
                          Container(
                              child: textView(widget.address,
                                  fontSize: SizeUtils.textSizeSmall,
                                  textColor: ColorUtils.appColorWhite_50)),
                        ],
                      ),
                    )),
                    Container(
                      child: textView(
                          widget.device.isBonded || widget.device.isConnected
                              ? StringUtils.txtPaired
                              : StringUtils.txtUnpaired,
                          fontSize: SizeUtils.textSizeMedium,
                          textColor: widget.device.isBonded
                              ? ColorUtils.appColorGreen
                              : ColorUtils.appColorWhite_50),
                    ).visible(
                        !(widget.device.isBonded || widget.device.isConnected)),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      alignment: Alignment.center,
                      child: RoundButton(
                        isStroked: true,
                        height: 30,
                        padding: const EdgeInsets.all(0),
                        textContent: widget.device.isConnected
                            ? StringUtils.txtConnected
                            : StringUtils.txtConnect,
                        textSize: SizeUtils.textSizeSMedium,
                        strokeColor: ColorUtils.appColorWhite_20,
                        radius: 5,
                        onPressed: () {
                          if (widget.onClickConnect != null) {
                            widget.onClickConnect!();
                          }
                        },
                      ),
                    ).visible(
                        widget.device.isBonded || widget.device.isConnected),
                  ],
                )),
            Container(
              color: ColorUtils.appColorWhite_20,
              height: 0.5,
            )
          ],
        ));
  }
}
