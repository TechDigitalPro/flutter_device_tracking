import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../base_view_model.dart';

class MainViewModel extends BaseViewModel with WidgetsBindingObserver {
  initialize(BuildContext context) async {
    notifyListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  initUI(BuildContext context) {}
}
