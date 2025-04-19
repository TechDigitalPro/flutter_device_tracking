import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/reset_pass_view_model.dart';

class ResetPassView extends StatelessWidget {
  ResetPassView({super.key});

  final TextEditingController textEditingControllerEmail =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPassViewModel>.reactive(
      viewModelBuilder: () => ResetPassViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, ResetPassViewModel model, Widget? child) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, details) async {
        if (result) return;
      },
      child: Scaffold(
        backgroundColor: ColorUtils.appColorPrimaryDark,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          child: Stack(
            children: <Widget>[
              SizedBox(width: width, height: height),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: height * 0.25,
                      alignment: Alignment.center,
                      child: textView(
                        StringUtils.txtResetPassword,
                        textColor: ColorUtils.appColorWhite,
                        fontSize: SizeUtils.textSizeXXLarge,
                        fontWeight: FontWeight.bold,
                        isCentered: true,
                      ),
                    ),
                    Container(
                      height: height * 0.1,
                      alignment: Alignment.center,
                      child: textView(
                        StringUtils.txtWeWillSend,
                        textColor: ColorUtils.appColorTextLight,
                        fontSize: SizeUtils.textSizeSMedium,
                        fontWeight: FontWeight.w500,
                        isCentered: true,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: ColorUtils.appColorWhite,
                        boxShadow: [
                          BoxShadow(
                            color: ColorUtils.appColorBlack_10,
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      width: width,
                      height: height * 0.6,
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  EditTextField(
                                    hintText: StringUtils.txtEmail,
                                    isPassword: false,
                                    isSecure: false,
                                    mController: textEditingControllerEmail,
                                    borderColor: ColorUtils.appColorPrimaryDark,
                                    backgroundColor: ColorUtils.appColorWhite,
                                    labelColor: ColorUtils.appColorPrimaryDark,
                                    borderRadius: 5,
                                    prefixIcon: Container(
                                      color: ColorUtils.appColorAccent_5,
                                      padding: const EdgeInsets.all(12),
                                      child: Icon(
                                        Icons.email_outlined,
                                        color: ColorUtils.appColorPrimaryDark,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.fromLTRB(
                                      5,
                                      10,
                                      5,
                                      10,
                                    ),
                                    child: RoundButton(
                                      isStroked: false,
                                      textContent: StringUtils.txtSend,
                                      textSize: SizeUtils.textSizeMedium,
                                      radius: 5,
                                      onPressed:
                                          () => model.onClickSend(
                                            context,
                                            textEditingControllerEmail.text,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      margin: const EdgeInsets.fromLTRB(
                                        0,
                                        0,
                                        0,
                                        20,
                                      ),
                                      child: GestureDetector(
                                        child: textViewUnderline(
                                          StringUtils.txtGoBack,
                                          textColor: ColorUtils.appColorAccent,
                                          fontSize: SizeUtils.textSizeMedium,
                                          fontWeight: FontWeight.w500,
                                          isCentered: false,
                                        ),
                                        onTap:
                                            () =>
                                                model.onClickRemember(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
