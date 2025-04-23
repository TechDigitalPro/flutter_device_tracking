import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../model/common/user_model.dart';
import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../base_view_model.dart';

class SignUpViewModel extends BaseViewModel {
  String name = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  initialize(BuildContext context) async {}

  onSetPrivacy(bool isSet) {
    notifyListeners();
  }

  onSetTerms(bool isSet) {
    notifyListeners();
  }

  onClickBack(BuildContext context) {
    finishView(context);
  }

  onClickSignUp(
    BuildContext context,
    String tName,
    String tEmail,
    String tRecoveryEmail,
    String tPassword,
    String tConfirmPassword,
  ) async {
    name = tName.trim();
    email = tEmail.trim();
    password = tPassword;
    confirmPassword = tConfirmPassword;

    if (checkValidate()) {
      UserModel userModel = UserModel();
      Future.delayed(const Duration(milliseconds: 100)).then(
        (value) => {
          networkService
              .registerUsingEmailPassword(
                name: name,
                email: email,
                password: password,
              )
              .then(
                (user) => {
                  if (user != null)
                    {
                      userModel.userName = name,
                      userModel.userEmail = email,
                      userModel.id = user.uid,
                      userModel.userPhone = '',
                      userModel.password = password,
                      userModel.recoveryEmail = tRecoveryEmail,
                      userModel.token = '',
                      userModel.devices = [],
                      userModel.isNotification = true,
                      userModel.created = Timestamp.fromDate(DateTime.now()),

                      networkService
                          .createOrUpdateUserData(userModel)
                          .then(
                            (value) {
                              if (context.mounted) {
                                sharedService.saveUser(userModel);
                                finishView(context);
                              }
                            },
                          ),
                    },
                },
              ),
        },
      );
    }
  }

  launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {}
  }

  bool checkValidate() {
    if (name.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterName, null);
      return false;
    }
    if (email.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterEmail, null);
      return false;
    }
    if (password.isEmpty) {
      showMessage(StringUtils.txtPleaseEnterPassword, null);
      return false;
    }
    if (password != confirmPassword) {
      showMessage(StringUtils.txtPasswordIsNotMatch, null);
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
