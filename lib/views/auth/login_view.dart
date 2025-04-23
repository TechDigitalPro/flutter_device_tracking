import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/size_utils.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../view_models/auth/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context, textEditingControllerEmail, textEditingControllerPassword),
    );
  }

  buildWidget(BuildContext context, LoginViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, details) async {
        if (result) return;
        showDialog(
          context: context,
          barrierColor: ColorUtils.appColorTransparent,
          builder: (BuildContext context) => const ExitDialog(),
        );
      },
      child: Scaffold(
        backgroundColor: ColorUtils.appColorPrimaryDark,
        appBar: AppBar(
          backgroundColor: ColorUtils.appColorPrimaryDark,
          title: textView(
            StringUtils.txtSignin,
            textColor: ColorUtils.appColorWhite,
            fontSize: SizeUtils.textSizeXLarge,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        model.userModel == null ? Container() :
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: textView(
                            model.userModel!.userName,
                            textColor: ColorUtils.appColorWhite,
                            fontSize: SizeUtils.textSizeXLarge,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        EditTextField(
                          hintText: StringUtils.txtEmail,
                          hintColor: ColorUtils.appColorWhite_80,
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
                          autoFocus: false,
                        ),
                        EditTextField(
                          hintText: StringUtils.txtPassword,
                          hintColor: ColorUtils.appColorWhite_80,
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
                          autoFocus: false,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: RoundButton(
                            height: 60,
                            isStroked: false,
                            textContent: StringUtils.txtSignin,
                            textSize: SizeUtils.textSizeLarge,
                            backgroundColor: ColorUtils.appColorBlack_30,
                            radius: 5,
                            onPressed: () {
                              model.onClickLogin(
                                context,
                                textEditingControllerEmail.text,
                                textEditingControllerPassword.text,
                              );
                            },
                          ),
                        ),
                        Container(
                          width: width,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            child: textViewUnderline(
                                StringUtils.txtForgotPassword,
                                textColor:
                                    ColorUtils.appColorWhite,
                                fontSize:
                                    SizeUtils.textSizeMedium,
                                fontWeight: FontWeight.w400,
                                isCentered: false),
                            onTap: () {
                              model.onClickResetPass(context);
                            },
                          ),
                        ),
                        Container(
                          width: width,
                          alignment: Alignment.center,
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              textView(
                                StringUtils.txtNoAccount,
                                textColor: ColorUtils.appColorWhite_80,
                                fontSize: SizeUtils.textSizeMedium,
                                fontWeight: FontWeight.w400,
                                isCentered: false,
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                child: textViewUnderline(
                                  StringUtils.txtSignUp,
                                  textColor: ColorUtils.appColorWhite,
                                  fontSize: SizeUtils.textSizeLarge,
                                  fontWeight: FontWeight.w500,
                                  isCentered: false,
                                ),
                                onTap: () {
                                  model.onClickRegister(context);
                                },
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
