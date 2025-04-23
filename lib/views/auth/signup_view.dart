import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController textEditingControllerName =
      TextEditingController();
  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerRecoveryEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();
  final TextEditingController textEditingControllerConfirmPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SignUpViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
            StringUtils.txtSignUp,
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
        body: SizedBox(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * 0.3,
                    alignment: Alignment.center,
                    child: Image.asset(
                      ImageUtils.imgIcLogo,
                      width: width,
                      height: height * 0.2,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EditTextField(
                          hintText: StringUtils.txtYourName,
                          isPassword: false,
                          isSecure: false,
                          mController: textEditingControllerName,
                          borderColor: ColorUtils.appColorBlack_50,
                          backgroundColor: ColorUtils.appColorBlack_50,
                          textColor: ColorUtils.appColorWhite,
                          cursorColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          borderRadius: 5,
                          prefixIcon: Container(
                            color: ColorUtils.appColorTransparent,
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.person_2_outlined,
                              color: ColorUtils.appColorWhite_80,
                              size: 30,
                            ),
                          ),
                        ),
                        EditTextField(
                          hintText: StringUtils.txtEmail,
                          isPassword: false,
                          isSecure: false,
                          mController: textEditingControllerEmail,
                          borderColor: ColorUtils.appColorBlack_50,
                          backgroundColor: ColorUtils.appColorBlack_50,
                          textColor: ColorUtils.appColorWhite,
                          cursorColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          borderRadius: 5,
                          prefixIcon: Container(
                            color: ColorUtils.appColorTransparent,
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.email_outlined,
                              color: ColorUtils.appColorWhite_80,
                              size: 30,
                            ),
                          ),
                        ),
                        EditTextField(
                          hintText: StringUtils.txtRecoveryEmail,
                          isPassword: false,
                          isSecure: false,
                          mController: textEditingControllerRecoveryEmail,
                          borderColor: ColorUtils.appColorBlack_50,
                          backgroundColor: ColorUtils.appColorBlack_50,
                          textColor: ColorUtils.appColorWhite,
                          cursorColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          borderRadius: 5,
                          prefixIcon: Container(
                            color: ColorUtils.appColorTransparent,
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.email_outlined,
                              color: ColorUtils.appColorWhite_80,
                              size: 30,
                            ),
                          ),
                        ),
                        EditTextField(
                          hintText: StringUtils.txtPassword,
                          isPassword: true,
                          isSecure: true,
                          mController: textEditingControllerPassword,
                          borderColor: ColorUtils.appColorBlack_50,
                          backgroundColor: ColorUtils.appColorBlack_50,
                          textColor: ColorUtils.appColorWhite,
                          cursorColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          borderRadius: 5,
                          prefixIcon: Container(
                            color: ColorUtils.appColorTransparent,
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.password_outlined,
                              color: ColorUtils.appColorWhite_80,
                              size: 30,
                            ),
                          ),
                        ),
                        EditTextField(
                          hintText: StringUtils.txtConfirmPassword,
                          isPassword: true,
                          isSecure: true,
                          mController: textEditingControllerConfirmPassword,
                          borderColor: ColorUtils.appColorBlack_50,
                          backgroundColor: ColorUtils.appColorBlack_50,
                          textColor: ColorUtils.appColorWhite,
                          cursorColor: ColorUtils.appColorWhite,
                          fontSize: SizeUtils.textSizeNormal,
                          borderRadius: 5,
                          prefixIcon: Container(
                            color: ColorUtils.appColorTransparent,
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.password_outlined,
                              color: ColorUtils.appColorWhite_80,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: RoundButton(
                                  height: 60,
                                  isStroked: false,
                                  textContent: StringUtils.txtSignUp,
                                  textSize: SizeUtils.textSizeLarge,
                                  radius: 5,
                                  backgroundColor: ColorUtils.appColorBlack_30,
                                  onPressed: () {
                                    model.onClickSignUp(
                                      context,
                                      textEditingControllerName.text,
                                      textEditingControllerEmail.text,
                                      textEditingControllerRecoveryEmail.text,
                                      textEditingControllerPassword.text,
                                      textEditingControllerConfirmPassword.text,
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: width,
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    textView(
                                      StringUtils.txtAlreadyHaveAnAccount,
                                      textColor: ColorUtils.appColorWhite_80,
                                      fontSize: SizeUtils.textSizeMedium,
                                      fontWeight: FontWeight.w400,
                                      isCentered: false,
                                    ),
                                    const SizedBox(width: 10),
                                    GestureDetector(
                                      child: textViewUnderline(
                                        StringUtils.txtSignin,
                                        textColor: ColorUtils.appColorWhite,
                                        fontSize: SizeUtils.textSizeLarge,
                                        fontWeight: FontWeight.w500,
                                        isCentered: false,
                                      ),
                                      onTap: () {
                                        model.onClickBack(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
