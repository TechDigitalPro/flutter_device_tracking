import 'package:device_tracking/extentions/widget_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/common/user_model.dart';
import '../../utils/string_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/login_view.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  late UserModel? userModel;

  initialize(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        try {
          showLoading();
          userModel = await networkService.getUserData();
          hideLoading();
          if (userModel != null) {
            if (context.mounted) {
              MainView().launch(context, isNewTask: true);
            }
          } else {
            showMessage(StringUtils.txtNoUserFound, null);
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        FirebaseAuth.instance.signOut();
        await Future.delayed(Duration(milliseconds: 100)).then((_) {
          if (context.mounted) {
            LoginView().launch(context, isNewTask: true);
          }
        });
      }
    } else {
      await Future.delayed(Duration(milliseconds: 100)).then((_) {
        if (context.mounted) {
          LoginView().launch(context, isNewTask: true);
        }
      });      
    }
  }
}
