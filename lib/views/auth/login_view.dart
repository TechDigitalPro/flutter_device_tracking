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
      onViewModelReady: (model) => model.initialize(context),
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
        body: SizedBox(
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                SizedBox(width: width, height: height),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: height * 0.4,
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImageUtils.imgIcLogo,
                          width: width,
                          height: height * 0.2,
                          fit: BoxFit.fitHeight,
                          color: ColorUtils.appColorWhite,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView(
                              StringUtils.txtSignin,
                              textColor: ColorUtils.appColorBlack,
                              fontSize: SizeUtils.textSizeNormal,
                              fontWeight: FontWeight.w400,
                            ),
                            const SizedBox(height: 10),
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
                              autoFocus: false,
                            ),
                            EditTextField(
                              hintText: StringUtils.txtPassword,
                              isPassword: true,
                              isSecure: true,
                              mController: textEditingControllerPassword,
                              borderColor: ColorUtils.appColorPrimaryDark,
                              backgroundColor: ColorUtils.appColorWhite,
                              labelColor: ColorUtils.appColorPrimaryDark,
                              borderRadius: 5,
                              prefixIcon: Container(
                                color: ColorUtils.appColorAccent_5,
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.password_outlined,
                                  color: ColorUtils.appColorPrimaryDark,
                                  size: 24,
                                ),
                              ),
                              autoFocus: false,
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: RoundButton(
                                isStroked: false,
                                textContent: StringUtils.txtSignin,
                                textSize: SizeUtils.textSizeMedium,
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
                              padding: const EdgeInsets.all(10),
                              color: ColorUtils.appColorTransparent,
                              child: GestureDetector(
                                child: textViewUnderline(
                                  StringUtils.txtResendVerificationEmail,
                                  textColor: ColorUtils.appColorBlack,
                                  fontSize: SizeUtils.textSizeSMedium,
                                  fontWeight: FontWeight.w400,
                                  isCentered: false,
                                ),
                                onTap: () {
                                  model.onClickResendVerificationEmail(context);
                                },
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: width,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: <Widget>[
                                            Theme(
                                              data: ThemeData(
                                                unselectedWidgetColor:
                                                    ColorUtils
                                                        .appColorTextLight,
                                                checkboxTheme: CheckboxThemeData(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          5,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              child: Checkbox(
                                                value: model.isRememberMe,
                                                onChanged: (bool? value) {
                                                  model.onSetRemember(value!);
                                                },
                                                activeColor:
                                                    ColorUtils.appColorAccent,
                                              ),
                                            ),
                                            textView(
                                              StringUtils.txtRememberMe,
                                              textColor:
                                                  ColorUtils.appColorTextLight,
                                              fontSize:
                                                  SizeUtils.textSizeSMedium,
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          child: textViewUnderline(
                                            StringUtils.txtForgotPassword,
                                            textColor:
                                                ColorUtils.appColorAccent,
                                            fontSize: SizeUtils.textSizeSMedium,
                                            fontWeight: FontWeight.w400,
                                            isCentered: false,
                                          ),
                                          onTap: () {
                                            model.onClickResetPass(context);
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        textView(
                                          StringUtils.txtNoAccount,
                                          textColor:
                                              ColorUtils.appColorTextLight,
                                          fontSize: SizeUtils.textSizeSMedium,
                                          fontWeight: FontWeight.w400,
                                          isCentered: false,
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          child: textViewUnderline(
                                            StringUtils.txtSignUp,
                                            textColor:
                                                ColorUtils.appColorAccent,
                                            fontSize: SizeUtils.textSizeMedium,
                                            fontWeight: FontWeight.w500,
                                            isCentered: false,
                                          ),
                                          onTap: () {
                                            model.onClickRegister(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
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
      ),
    );
  }
}
