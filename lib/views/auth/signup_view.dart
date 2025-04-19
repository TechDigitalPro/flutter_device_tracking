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
  final TextEditingController textEditingControllerPassword =
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
                        height: height * 0.35,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textView(
                              StringUtils.txtSignUp,
                              textColor: ColorUtils.appColorBlack,
                              fontSize: SizeUtils.textSizeNormal,
                              fontWeight: FontWeight.w400,
                            ),
                            const SizedBox(height: 10),
                            EditTextField(
                              hintText: StringUtils.txtYourName,
                              isPassword: false,
                              isSecure: false,
                              mController: textEditingControllerName,
                              borderColor: ColorUtils.appColorPrimaryDark,
                              backgroundColor: ColorUtils.appColorWhite,
                              labelColor: ColorUtils.appColorPrimaryDark,
                              borderRadius: 5,
                              prefixIcon: Container(
                                color: ColorUtils.appColorAccent_5,
                                padding: const EdgeInsets.all(12),
                                child: Icon(
                                  Icons.person_2_outlined,
                                  color: ColorUtils.appColorPrimaryDark,
                                  size: 24,
                                ),
                              ),
                            ),
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
                            ),
                            SizedBox(
                              child: SizedBox(
                                width: width,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(height: 10),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.fromLTRB(
                                        5,
                                        5,
                                        5,
                                        5,
                                      ),
                                      child: RoundButton(
                                        isStroked: false,
                                        textContent: StringUtils.txtSignUp,
                                        textSize: SizeUtils.textSizeMedium,
                                        radius: 5,
                                        backgroundColor:
                                            ColorUtils.appColorAccent,
                                        onPressed: () {
                                          model.onClickSignUp(
                                            context,
                                            textEditingControllerName.text,
                                            textEditingControllerEmail.text,
                                            textEditingControllerPassword.text,
                                          );
                                        },
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        textView(
                                          StringUtils.txtAlreadyHaveAnAccount,
                                          textColor:
                                              ColorUtils.appColorTextWhite,
                                          fontSize: SizeUtils.textSizeSMedium,
                                          fontWeight: FontWeight.w400,
                                          isCentered: false,
                                        ),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          child: textViewUnderline(
                                            StringUtils.txtSignin,
                                            textColor:
                                                ColorUtils.appColorAccent,
                                            fontSize: SizeUtils.textSizeMedium,
                                            fontWeight: FontWeight.w500,
                                            isCentered: false,
                                          ),
                                          onTap: () {
                                            model.onClickBack(context);
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
