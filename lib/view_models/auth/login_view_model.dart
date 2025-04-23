import 'package:device_tracking/extentions/widget_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/common/user_model.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../../views/auth/reset_pass_view.dart';
import '../../views/auth/signup_view.dart';
import '../../views/main/main_view.dart';
import '../base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  String email = '';
  String password = '';
  late UserModel? userModel = UserModel();
  bool isFirst = false;
  bool isRememberMe = false;
 
  initialize(BuildContext context, 
  TextEditingController editingControllerEmail, TextEditingController editingControllerPassword) async {
    isFirst = await sharedService.getIsFirst();
    userModel = await sharedService.getUser();
    
    if (userModel != null) {
      editingControllerEmail.text = userModel!.userEmail ?? '';
      editingControllerPassword.text = userModel!.password ?? '';
    }

    notifyListeners();
  }

  onSetRemember(bool isSet) {
    isRememberMe = isSet;
    notifyListeners();
  }

  onClickLogin(BuildContext context, String tEmail, String tPassword) async {
    email = tEmail.trim();
    password = tPassword;
    if (checkValidate()) {
      await networkService
          .signInUsingEmailPassword(email: email, password: password)
          .then(
            (value) => {
              if (value != null)
                {
                  if (value.emailVerified)
                    {
                      networkService.getUserData().then((userData) async {
                        userModel = userData;
                        networkService.createOrUpdateUserData(userModel);
                        if (context.mounted) {
                          MainView().launch(context, isNewTask: true);
                        }
                      }),
                    }
                  else
                    {
                      value.sendEmailVerification().then(
                        (value) => {
                          showMessage(
                            StringUtils.txtCheckEmailVerification,
                            null,
                          ),
                        },
                      ),
                    },
                }
            },
          );
    }
  }

  onClickRegister(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    SignUpView().launch(context);
  }

  onClickResetPass(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    ResetPassView().launch(context);
  }

  onClickResendVerificationEmail(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      user.sendEmailVerification().then(
        (value) => {
          showMessage(
            '${StringUtils.txtEmailVerificationLinkIsSent} ${user.email}',
            null,
          ),
        },
      );
    } else {
      showMessage(StringUtils.txtPleaseLoginOrCreateAccount, null);
    }
  }

  bool checkValidate() {
    if (email.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterEmail, null);
      return false;
    }
    if (password.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterPassword, null);
      return false;
    }
    if (!isValidEmail(email)) {
      showMessage(StringUtils.txtPleaseEnterCorrectEmail, null);
      return false;
    }
    if (!isValidPassword(password)) {
      showMessage(StringUtils.txtPleaseEnterCorrectPassword, null);
      return false;
    }
    return true;
  }
}
