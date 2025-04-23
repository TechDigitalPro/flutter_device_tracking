import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/string_utils.dart';
import '../../utils/system_utils.dart';
import '../../utils/widget_utils.dart';
import '../base_view_model.dart';

class ResetPassViewModel extends BaseViewModel {
  initialize(BuildContext context) async {}

  onClickSend(BuildContext context, String email) async {
    if (email.isNotEmpty && isValidEmail(email)) {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showMessage(StringUtils.txtSentPassword, null);

      if (context.mounted) {
        finishView(context);
      }
    } else {
      showMessage(StringUtils.txtPleaseCheckEmail, null);
    }
  }

  onClickRemember(BuildContext context) {
    finishView(context);
  }

  onClickBack(BuildContext context) {
    finishView(context);
  }
}
