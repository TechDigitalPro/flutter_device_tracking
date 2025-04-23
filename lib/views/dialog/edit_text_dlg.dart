import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';

// ignore: must_be_immutable
class EditTextDlg extends StatefulWidget {
  EditTextDlg({super.key, this.title, this.hint, required this.name, this.onClickSave});

  String? title;
  String? hint;
  final String name;
  Function? onClickSave;
  TextEditingController? textEditingController = TextEditingController();

  @override
  State<EditTextDlg> createState() => _EditTextDlgState();
}

class _EditTextDlgState extends State<EditTextDlg> {
  @override
  Widget build(BuildContext context) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    widget.textEditingController!.text = widget.name;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
      backgroundColor: ColorUtils.appColorTransparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: ColorUtils.appColorWhite,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: ColorUtils.appColorBlack_50,
                  offset: const Offset(0, 10),
                  blurRadius: 10),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              color: ColorUtils.appColorPrimaryDark,
              child: textView(
                  widget.title ?? StringUtils.txtEdit,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.w600,
                  isCentered: true,
                  maxLine: 4),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: EditTextFieldRound(
                hintText: widget.hint ?? StringUtils.txtEdit,
                isPassword: false,
                isSecure: false,
                mController: widget.textEditingController!,
                borderColor: ColorUtils.appColorBlack_50,
                textColor: ColorUtils.appColorBlack,
                hintColor: ColorUtils.appColorBlack_50,
                borderRadius: 5,
                contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                isCentered: false,
                textCapitalization: TextCapitalization.sentences,
                maxLine: 1,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const SizedBox(width: 10,),
                Expanded(
                  child: RoundButton(
                    isStroked: false,
                    textContent: StringUtils.txtCancel,
                    strokeColor: ColorUtils.appColorWhite_80,
                    backgroundColor: ColorUtils.appColorRed,
                    textSize: SizeUtils.textSizeMedium,
                    textColor: ColorUtils.appColorWhite,
                    radius: 5,
                    onPressed: () {
                      finishView(context);
                    })
                  ),
                const SizedBox(width: 10,),
                Expanded(
                  child: RoundButton(
                    isStroked: false,
                    textContent: StringUtils.txtSave,
                    strokeColor: ColorUtils.appColorWhite_80,
                    backgroundColor: ColorUtils.appColorPrimary,
                    textSize: SizeUtils.textSizeMedium,
                    textColor: ColorUtils.appColorWhite,
                    radius: 5,
                    onPressed: () {
                      if (widget.onClickSave != null &&
                          widget.textEditingController!.text.isNotEmpty) {
                        widget.onClickSave!(widget.textEditingController!.text);
                      }
                      finishView(context);
                    }),
                ),
                const SizedBox(width: 10,),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
