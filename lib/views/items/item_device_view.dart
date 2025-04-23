import 'package:device_tracking/model/common/device_status.dart';
import 'package:flutter/material.dart';

import '../../model/common/device_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/widget_utils.dart';

class ItemDeviceView extends StatefulWidget {
  const ItemDeviceView({
    super.key,
    required this.model,
    required this.onDelete,
    required this.onAddRemove,
  });

  final DeviceModel model;
  final VoidCallback onDelete;
  final Function onAddRemove;

  @override
  ItemDeviceViewState createState() => ItemDeviceViewState();
}

class ItemDeviceViewState extends State<ItemDeviceView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(5),
      child: SizedBox(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: width * 0.2,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: textView(
                widget.model.name ?? '',
                fontSize: SizeUtils.textSizeMedium,
                fontWeight: FontWeight.w400,
                textColor: ColorUtils.appColorWhite,
                maxLine: 1,
              ),
            ),
            Container(
              width: width * 0.3,
              alignment: Alignment.centerLeft,
              child: textView(
                widget.model.description ?? '',
                fontSize: SizeUtils.textSizeMedium,
                fontWeight: FontWeight.w400,
                textColor: ColorUtils.appColorWhite,
                maxLine: 1,
              ),
            ),
            Container(
              width: width * 0.2,
              alignment: Alignment.centerLeft,
              child: textView(
                widget.model.status ?? '',
                fontSize: SizeUtils.textSizeMedium,
                fontWeight: FontWeight.w400,
                textColor:
                    widget.model.status == DeviceStatus.connected
                      ? ColorUtils.appColorGreen
                      : ColorUtils.appColorRed,
                maxLine: 1,
              ),
            ),
            SizedBox(
              width: width * 0.1,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: ColorUtils.appColorTransparent,
                child: GestureDetector(
                  onTap: () {
                    widget.onDelete();
                  },
                  child: Icon(
                    Icons.delete,
                    color: ColorUtils.appColorWhite,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
