import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
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
        appBar: AppBar(
          backgroundColor: ColorUtils.appColorPrimaryDark,
          title: textView(
            StringUtils.txtResetPassword,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    height: height * 0.1,
                    alignment: Alignment.center,
                    child: textView(
                      StringUtils.txtWeWillSend,
                      textColor: ColorUtils.appColorWhite_80,
                      fontSize: SizeUtils.textSizeMedium,
                      fontWeight: FontWeight.w500,
                      isCentered: true,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: width,
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
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: RoundButton(
                              height: 60,
                              isStroked: false,
                              textContent: StringUtils.txtSend,
                              textSize: SizeUtils.textSizeLarge,
                              backgroundColor: ColorUtils.appColorBlack_30,
                              radius: 5,
                              onPressed: () {
                                model.onClickSend(
                                  context,
                                  textEditingControllerEmail.text,
                                );
                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.bottomCenter,
                              margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                              child: GestureDetector(
                                child: textViewUnderline(
                                  StringUtils.txtGoBack,
                                  textColor: ColorUtils.appColorWhite,
                                  fontSize: SizeUtils.textSizeNormal,
                                  fontWeight: FontWeight.w500,
                                  isCentered: false,
                                ),
                                onTap: () {
                                  model.onClickRemember(context);
                                },
                              ),
                            ),
                        ],
                      ),
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
