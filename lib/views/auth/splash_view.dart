import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../utils/color_utils.dart';
import '../../utils/image_utils.dart';
import '../../utils/system_utils.dart';
import '../../view_models/auth/splash_view_model.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),
      builder: (context, model, child) => buildWidget(context, model, child),
      onViewModelReady: (model) => model.initialize(context),
    );
  }

  buildWidget(BuildContext context, SplashViewModel model, Widget? child) {
    setStatusBarColor(ColorUtils.appColorTransparent);
    var width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (result, details) async {
        if (result) return;
      },
      child: Scaffold(
        backgroundColor: ColorUtils.appColorPrimaryDark,
        body: Container(
          alignment: Alignment.center,
          child: Image.asset(
            ImageUtils.imgIcLogo,
            width: width * 0.5,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
