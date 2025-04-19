import 'package:flutter/material.dart';

import '../service/common_service.dart';
import '../service/language_change_provider.dart';
import '../service/network_service.dart';
import '../service/shared_service.dart';
import '../settings/locator.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;
  bool get isBusy => _busy;

  CommonService commonService = locator<CommonService>();
  NetworkService networkService = locator<NetworkService>();
  SharedService sharedService = locator<SharedService>();
  LanguageChangeProvider languageChangeProvider =
      locator<LanguageChangeProvider>();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
