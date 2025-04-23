import 'dart:io';
import 'dart:ui';
// ignore: unused_import
import 'dart:ui' as ui;
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import 'color_utils.dart';
import 'size_utils.dart';
import 'string_utils.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 10,
      shadowColor: ColorUtils.appColorBlack,
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.white,
      content: Text(StringUtils.txtDoYouWantToExit,
          style: primaryTextStyle(color: ColorUtils.appColorBlack)),
      actions: [
        TextButton(
          child: Text(StringUtils.txtCancel,
              style: secondaryTextStyle(color: ColorUtils.appColorBlack)),
          onPressed: () {
            finish(context);
          },
        ),
        TextButton(
          child: Text(StringUtils.txtExit,
              style: secondaryTextStyle(color: ColorUtils.appColorPrimary)),
          onPressed: () {
            finish(context);
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CustomDialog extends StatelessWidget {
  CustomDialog({
    super.key,
    required this.title,
    required this.description,
    required this.okButtonStr,
    required this.cancelButtonStr,
    required this.okClicked,
    this.cancelClicked,
  });

  String title;
  String description;
  String okButtonStr;
  String cancelButtonStr;
  Function okClicked;
  Function? cancelClicked;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      shadowColor: ColorUtils.appColorWhite_20,
      contentPadding: const EdgeInsets.all(15),
      backgroundColor: ColorUtils.appColorPrimary,
      content: Text(description,
          style: primaryTextStyle(color: ColorUtils.appColorWhite)),
      actions: [
        TextButton(
          child: Text(cancelButtonStr,
              style: secondaryTextStyle(color: ColorUtils.appColorWhite)),
          onPressed: () {
            finish(context);
            if (cancelClicked != null) {
              cancelClicked!();
            }
          },
        ),
        TextButton(
          child: Text(okButtonStr,
              style: secondaryTextStyle(color: ColorUtils.appColorGreen)),
          onPressed: () {
            finish(context);
            okClicked();
          },
        ),
      ],
    );
  }
}

Widget textView(
  String? text, {
  var fontSize = SizeUtils.textSizeNormal,
  Color? textColor,
  var fontFamily,
  var fontWeight,
  var isCentered = false,
  var textAlign = TextAlign.start,
  var maxLine = 50,
  var latterSpacing = 0.1,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
  bool lineUnder = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text ?? '',
    textAlign: isCentered ? TextAlign.center : textAlign,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.cabin(
      fontStyle: fontFamily ?? FontStyle.normal,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: textColor ?? ColorUtils.appColorBlack,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget textViewAntonio(
  String? text, {
  var fontSize = SizeUtils.textSizeNormal,
  Color? textColor,
  var fontFamily,
  var fontWeight,
  var isCentered = false,
  var textAlign = TextAlign.start,
  var maxLine = 50,
  var latterSpacing = 0.1,
  bool textAllCaps = false,
  var isLongText = false,
  bool lineThrough = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : textAlign,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.antonio(
      fontStyle: fontFamily ?? FontStyle.normal,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: textColor ?? ColorUtils.appColorBlack,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration:
          lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

Widget textViewUnderline(
  String? text, {
  var fontSize = SizeUtils.textSizeNormal,
  Color? textColor,
  var fontFamily,
  var fontWeight,
  var isCentered = false,
  var textAlign = TextAlign.start,
  var maxLine = 50,
  var latterSpacing = 0.1,
  bool textAllCaps = false,
  var isLongText = false,
  bool dash = false,
}) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : textAlign,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontStyle: fontFamily ?? FontStyle.normal,
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: textColor ?? ColorUtils.appColorBlack,
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: TextDecoration.underline,
      decorationStyle:
          dash ? TextDecorationStyle.dashed : TextDecorationStyle.solid,
      decorationColor: textColor ?? ColorUtils.appColorBlack,
    ),
  );
}

// ignore: must_be_immutable
class EditTextField extends StatefulWidget {
  EditTextField(
      {super.key,
      required this.hintText,
      required this.isPassword,
      required this.isSecure,
      required this.mController,
      this.prefixIcon,
      this.onTap,
      this.isEnable,
      this.isReadOnly,
      this.enableInteractiveSelection,
      this.textInputType,
      this.inputFormatters,
      this.autoFocus,
      this.cursorColor,
      this.hintColor,
      this.labelColor,
      this.borderColor,
      this.backgroundColor,
      this.borderRadius,
      this.textColor,
      this.fontFamily,
      this.fontWeight,
      this.fontSize,
      this.isCentered,
      this.maxLine,
      this.latterSpacing,
      this.lineThrough});

  String hintText;
  bool isPassword;
  bool isSecure;
  TextEditingController mController;

  Widget? prefixIcon;
  bool? enableInteractiveSelection;
  bool? isEnable;
  bool? isReadOnly;
  Color? cursorColor;
  Color? hintColor;
  Color? labelColor;
  Color? borderColor;
  Color? backgroundColor;
  double? borderRadius;
  Color? textColor;
  FontStyle? fontFamily;
  FontWeight? fontWeight;
  double? fontSize;
  bool? isCentered;
  int? maxLine;
  double? latterSpacing;
  bool? lineThrough;
  bool? autoFocus;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatters;
  VoidCallback? onTap;

  @override
  EditTextFieldState createState() => EditTextFieldState();
}

class EditTextFieldState extends State<EditTextField> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSecure) {
      return Padding(
          padding: const EdgeInsets.all(5),
          child: TextField(
            style: GoogleFonts.poppins(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeSMedium,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor ?? ColorUtils.appColorBlack,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
                hintText: widget.hintText,
                labelText: widget.hintText,
                prefixIcon: widget.prefixIcon ?? Container(width: 0,),
                hintStyle: TextStyle(
                    color: widget.hintColor ?? ColorUtils.appColorTextLight),
                labelStyle: TextStyle(
                    color: widget.labelColor ?? ColorUtils.appColorTextLight,
                    fontSize: SizeUtils.textSizeSMedium),
                filled: true,
                fillColor:
                    widget.backgroundColor ?? ColorUtils.appColorGreyLight,
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 30.0),
                  borderSide: BorderSide(
                      color:
                          widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 30.0),
                  borderSide: BorderSide(
                      color:
                          widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isPassword = !widget.isPassword;
                    });
                  },
                  child: Icon(
                      widget.isPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: ColorUtils.appColorWhite_80),
                )),
            cursorColor: widget.cursorColor ?? ColorUtils.appColorBlack,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.text,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap,
            readOnly: widget.isReadOnly ?? false,
            enabled: widget.isEnable ?? true,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.all(5),
          child: TextField(
            style: GoogleFonts.poppins(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeSMedium,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor ?? ColorUtils.appColorBlack,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: const EdgeInsets.fromLTRB(25, 8, 4, 8),
              hintText: widget.hintText,
              labelText: widget.hintText,
              prefixIcon: widget.prefixIcon ?? Container(width: 0,),
              hintStyle: TextStyle(
                  color: widget.hintColor ?? ColorUtils.appColorTextLight),
              labelStyle: TextStyle(
                  color: widget.labelColor ?? ColorUtils.appColorTextLight,
                  fontSize: SizeUtils.textSizeSMedium),
              filled: true,
              fillColor: widget.backgroundColor ?? ColorUtils.appColorGreyLight,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 30.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 30.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
            ),
            cursorColor: widget.cursorColor ?? ColorUtils.appColorBlack,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.text,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap,
            readOnly: widget.isReadOnly ?? false,
            enabled: widget.isEnable ?? true,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
          ));
    }
  }
}

// ignore: must_be_immutable
class EditTextFieldWithoutLabel extends StatefulWidget {
  EditTextFieldWithoutLabel(
      {super.key,
      required this.hintText,
      required this.isPassword,
      required this.isSecure,
      required this.mController,
      required this.textColor,
      this.onTap,
      this.focusNode,
      this.textInputAction,
      this.isEnable,
      this.readOnly,
      this.enableInteractiveSelection,
      this.textInputType,
      this.textCapitalization,
      this.inputFormatters,
      this.autoFocus,
      this.cursorColor,
      this.hintColor,
      this.borderColor,
      this.backgroundColor,
      this.borderRadius,
      this.fontFamily,
      this.fontWeight,
      this.fontSize,
      this.isCentered,
      this.maxLine,
      this.minLine,
      this.latterSpacing,
      this.lineThrough});
  String hintText;
  bool isPassword;
  bool isSecure;
  TextEditingController mController;

  bool? enableInteractiveSelection;
  bool? isEnable;
  bool? readOnly;
  Color? cursorColor;
  Color? hintColor;
  Color? borderColor;
  Color? backgroundColor;
  double? borderRadius;
  Color textColor;
  FontStyle? fontFamily;
  FontWeight? fontWeight;
  double? fontSize;
  bool? isCentered;
  int? maxLine;
  int? minLine;
  double? latterSpacing;
  bool? lineThrough;
  bool? autoFocus;
  TextInputType? textInputType;
  TextCapitalization? textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  VoidCallback? onTap;
  TextInputAction? textInputAction;
  FocusNode? focusNode;

  @override
  EditTextFieldWithoutLabelState createState() =>
      EditTextFieldWithoutLabelState();
}

class EditTextFieldWithoutLabelState extends State<EditTextFieldWithoutLabel> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSecure) {
      return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextField(
            focusNode: widget.focusNode,
            style: TextStyle(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeNormal,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                hintText: widget.hintText,
                hintStyle: TextStyle(
                    color: widget.hintColor ?? ColorUtils.appColorTextLight),
                labelStyle: TextStyle(
                    color: widget.hintColor ?? widget.textColor,
                    fontSize: SizeUtils.textSizeMedium),
                filled: true,
                fillColor:
                    widget.backgroundColor ?? ColorUtils.appColorTransparent,
                enabledBorder: UnderlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 0.0),
                  borderSide: BorderSide(
                      color:
                          widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 0.0),
                  borderSide: BorderSide(
                      color:
                          widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.isPassword = !widget.isPassword;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Icon(
                          widget.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: widget.textColor),
                    ))),
            cursorColor: widget.cursorColor ?? widget.textColor,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLine ?? 1,
            minLines: widget.minLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.multiline,
            textInputAction: widget.textInputAction ?? TextInputAction.newline,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap,
            enabled: widget.isEnable ?? true,
            readOnly: widget.readOnly ?? false,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextField(
            focusNode: widget.focusNode,
            style: TextStyle(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeNormal,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: widget.hintColor ?? ColorUtils.appColorTextLight),
              labelStyle: TextStyle(
                  color: widget.hintColor ?? widget.textColor,
                  fontSize: SizeUtils.textSizeMedium),
              filled: true,
              fillColor:
                  widget.backgroundColor ?? ColorUtils.appColorTransparent,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
            ),
            cursorColor: widget.cursorColor ?? widget.textColor,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            maxLines: widget.maxLine ?? 1,
            minLines: widget.minLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.multiline,
            textInputAction: widget.textInputAction ?? TextInputAction.newline,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap,
            enabled: widget.isEnable ?? true,
            readOnly: widget.readOnly ?? false,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
          ));
    }
  }
}

// ignore: must_be_immutable
class EditTextFieldRound extends StatefulWidget {
  EditTextFieldRound(
      {super.key,
      required this.hintText,
      required this.isPassword,
      required this.isSecure,
      required this.mController,
      required this.textColor,
      this.onTap,
      this.focusNode,
      this.textInputAction,
      this.isEnable,
      this.readOnly,
      this.enableInteractiveSelection,
      this.textInputType,
      this.textCapitalization,
      this.inputFormatters,
      this.autoFocus,
      this.cursorColor,
      this.hintColor,
      this.borderColor,
      this.backgroundColor,
      this.borderRadius,
      this.fontFamily,
      this.fontWeight,
      this.fontSize,
      this.isCentered,
      this.maxLine,
      this.minLine,
      this.latterSpacing,
      this.contentPadding,
      this.lineThrough});
  String hintText;
  bool isPassword;
  bool isSecure;
  TextEditingController mController;

  bool? enableInteractiveSelection;
  bool? isEnable;
  bool? readOnly;
  Color? cursorColor;
  Color? hintColor;
  Color? borderColor;
  Color? backgroundColor;
  double? borderRadius;
  Color textColor;
  FontStyle? fontFamily;
  FontWeight? fontWeight;
  double? fontSize;
  bool? isCentered;
  int? maxLine;
  int? minLine;
  double? latterSpacing;
  bool? lineThrough;
  bool? autoFocus;
  EdgeInsetsGeometry? contentPadding;
  TextInputType? textInputType;
  TextCapitalization? textCapitalization;
  List<TextInputFormatter>? inputFormatters;
  VoidCallback? onTap;
  TextInputAction? textInputAction;
  FocusNode? focusNode;

  @override
  EditTextFieldRoundState createState() => EditTextFieldRoundState();
}

class EditTextFieldRoundState extends State<EditTextFieldRound> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSecure) {
      return Padding(
          padding: const EdgeInsets.all(0),
          child: TextField(
            focusNode: widget.focusNode,
            style: TextStyle(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeMedium,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.fromLTRB(0, 5, 0, 5),
                hintText: widget.hintText,
                //labelText: widget.hintText,
                hintStyle: TextStyle(
                    color: widget.hintColor ?? ColorUtils.appColorTextLight),
                labelStyle: TextStyle(
                    color: widget.hintColor ?? widget.textColor,
                    fontSize: SizeUtils.textSizeMedium),
                filled: true,
                fillColor:
                    widget.backgroundColor ?? ColorUtils.appColorTransparent,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
                  borderSide: BorderSide(
                      color: widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
                  borderSide: BorderSide(
                      color: widget.borderColor ?? ColorUtils.appColorTransparent,
                      width: 1),
                ),
                suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.isPassword = !widget.isPassword;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Icon(
                          widget.isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: widget.textColor),
                    ))),
            cursorColor: widget.cursorColor ?? widget.textColor,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            maxLines: widget.maxLine ?? 1,
            minLines: widget.minLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.multiline,
            textInputAction: widget.textInputAction ?? TextInputAction.newline,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap,
            enabled: widget.isEnable ?? true,
            readOnly: widget.readOnly ?? false,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
          ));
    } else {
      return Padding(
          padding: const EdgeInsets.all(0),
          child: TextField(
            focusNode: widget.focusNode,
            style: TextStyle(
              fontStyle: widget.fontFamily ?? FontStyle.normal,
              fontSize: widget.fontSize ?? SizeUtils.textSizeMedium,
              fontWeight: widget.fontWeight ?? FontWeight.normal,
              color: widget.textColor,
              height: 1.5,
              letterSpacing: widget.latterSpacing ?? 0.5,
              decoration: widget.lineThrough ?? false
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
            controller: widget.mController,
            obscureText: widget.isPassword,
            decoration: InputDecoration(
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.fromLTRB(0, 5, 0, 5),
              hintText: widget.hintText,
              //labelText: widget.hintText,
              hintStyle: TextStyle(
                  color: widget.hintColor ?? ColorUtils.appColorTextLight),
              labelStyle: TextStyle(
                  color: widget.hintColor ?? widget.textColor,
                  fontSize: SizeUtils.textSizeMedium),
              filled: true,
              fillColor:
                  widget.backgroundColor ?? ColorUtils.appColorTransparent,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
                borderSide: BorderSide(
                    color: widget.borderColor ?? ColorUtils.appColorTransparent,
                    width: 1),
              ),
            ),
            cursorColor: widget.cursorColor ?? widget.textColor,
            textAlign:
                widget.isCentered ?? false ? TextAlign.center : TextAlign.start,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.sentences,
            maxLines: widget.maxLine ?? 1,
            minLines: widget.minLine ?? 1,
            autofocus: widget.autoFocus ?? false,
            keyboardType: widget.textInputType ?? TextInputType.multiline,
            textInputAction: widget.textInputAction ?? TextInputAction.newline,
            inputFormatters: widget.inputFormatters ?? [],
            onTap: widget.onTap,
            enabled: widget.isEnable ?? true,
            readOnly: widget.readOnly ?? false,
            enableInteractiveSelection:
                widget.enableInteractiveSelection ?? true,
          ));
    }
  }
}

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

class WalkThrough extends StatelessWidget {
  final String? textTitle;
  final String? textContent;
  final String walkImg;
  final String? backImg;

  const WalkThrough(
      {super.key,
      this.textTitle,
      this.textContent,
      required this.walkImg,
      this.backImg});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        backImg != null
            ? Image.asset(backImg!, width: width, fit: BoxFit.fitWidth)
            : Container(),
        Positioned(
          bottom: height * 0.15,
          left: 0,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                walkImg,
                width: width * 0.4,
                fit: BoxFit.cover,
              ),
              Container(
                width: width * 0.8,
                padding: const EdgeInsets.all(10),
                child: textView(
                  textTitle,
                  textColor: ColorUtils.appColorWhite,
                  fontSize: SizeUtils.textSizeNormal,
                  fontWeight: FontWeight.bold,
                  textAllCaps: true,
                  isCentered: true,
                ),
              ),
              Container(
                width: width * 0.8,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: textView(textContent,
                    textColor: ColorUtils.appColorWhite,
                    fontSize: SizeUtils.textSizeSMedium,
                    isCentered: true),
              )
            ],
          ),
        ),
      ],
    );
  }
}

BoxDecoration boxDecoration(
    {double? radius,
    Color? borderColor,
    Color? bgColor,
    var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? ColorUtils.appColorAccent,
    boxShadow: showShadow
        ? defaultBoxShadow(shadowColor: shadowColorGlobal)
        : [const BoxShadow(color: Colors.transparent)],
    border: Border.all(color: borderColor ?? ColorUtils.appColorAccent),
    borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
  );
}

class RoundButton extends StatefulWidget {
  final String textContent;
  final Color? textColor;
  final double? textSize;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool isStroked;
  final double? elevation;
  final bool? isAllCaps;
  final double? height;
  final double? radius;
  final Color? backgroundColor;
  final Color? strokeColor;

  const RoundButton({
    super.key,
    required this.isStroked,
    required this.textContent,
    this.textColor,
    this.textSize,
    this.height,
    this.radius,
    this.padding,
    this.backgroundColor,
    this.strokeColor,
    this.elevation,
    this.isAllCaps,
    required this.onPressed,
  });

  @override
  RoundButtonState createState() => RoundButtonState();
}

class RoundButtonState extends State<RoundButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      height: widget.height ?? 40,
      elevation: widget.elevation ?? 1,
      color: widget.backgroundColor ?? ColorUtils.appColorAccent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 10),
          side: BorderSide(
            color: widget.isStroked
                ? widget.strokeColor ?? ColorUtils.appColorAccent
                : ColorUtils.appColorTransparent,
          )),
      child: Container(
        height: widget.height ?? 40,
        padding: widget.padding ?? const EdgeInsets.fromLTRB(25, 5, 25, 5),
        alignment: Alignment.center,
        child: textView(widget.textContent,
            fontSize: widget.textSize ?? SizeUtils.textSizeNormal,
            textColor: widget.textColor ?? ColorUtils.appColorWhite,
            fontWeight: FontWeight.w500,
            textAllCaps: widget.isAllCaps ?? false,
            isCentered: true,
            maxLine: 2),
      ),
    );
  }
}

class RoundButtonGradient extends StatefulWidget {
  final String textContent;
  final Color? textColor;
  final double? textSize;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  final bool isStroked;
  final bool? isAllCaps;
  final double? height;
  final double? radius;
  final Color? gradientColorStart;
  final Color? gradientColorCenter;
  final Color? gradientColorEnd;
  final Color? strokeColor;

  const RoundButtonGradient({
    super.key,
    required this.isStroked,
    required this.textContent,
    this.textColor,
    this.textSize,
    this.height,
    this.radius,
    this.padding,
    this.gradientColorStart,
    this.gradientColorCenter,
    this.gradientColorEnd,
    this.strokeColor,
    this.isAllCaps,
    required this.onPressed,
  });

  @override
  RoundButtonGradientState createState() => RoundButtonGradientState();
}

class RoundButtonGradientState extends State<RoundButtonGradient> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      height: widget.height ?? 45,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.radius ?? 10),
          side: BorderSide(
            color: widget.isStroked
                ? widget.strokeColor ?? ColorUtils.appColorAccent
                : ColorUtils.appColorTransparent,
          )),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.gradientColorStart ?? ColorUtils.appColorPrimaryDark,
              widget.gradientColorCenter ?? ColorUtils.appColorPrimaryDark,
              widget.gradientColorEnd ?? ColorUtils.appColorPrimary
            ],
          ),
        ),
        height: widget.height ?? 45,
        padding: widget.padding ?? const EdgeInsets.fromLTRB(25, 5, 25, 5),
        alignment: Alignment.center,
        child: textView(widget.textContent,
            fontSize: widget.textSize ?? SizeUtils.textSizeNormal,
            textColor: widget.textColor ?? ColorUtils.appColorWhite,
            fontWeight: FontWeight.w500,
            textAllCaps: widget.isAllCaps ?? false,
            isCentered: true),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void showMessage(String str, double? alignment) {
  BotToast.showCustomText(
      toastBuilder: (cancelFunc) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     ColorUtils.appColorPrimaryDark,
            //     ColorUtils.appColorPrimaryDark,
            //     ColorUtils.appColorPrimary
            //   ],
            // ),
            color: ColorUtils.appColorWhite,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: ColorUtils.appColorPrimaryDark),
          ),
          child: textView(str,
              textColor: ColorUtils.appColorBlack,
              fontSize: SizeUtils.textSizeMedium,
              maxLine: 50,
              isCentered: true),
        );
      },
      align: Alignment(0, alignment ?? 0.9));
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    //setStatusBarColor(ColorUtils.appColorTransparent);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: ColorUtils.appColorGreyDark,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: CircularProgressIndicator(
        backgroundColor: ColorUtils.appColorWhite,
        color: ColorUtils.appColorPrimary.withAlpha(100),
      ),
    );
  }
}

void showLoading() {
  BotToast.showCustomLoading(
    toastBuilder: (_) => const LoadingWidget(),
    backgroundColor: ColorUtils.appColorTransparent,
  );
}

void hideLoading() {
  BotToast.closeAllLoading();
}