import 'package:flutter/material.dart';

class LanguageChangeProvider with ChangeNotifier {
  Locale currentLocale = const Locale('en');

  Locale get getCurLocale => currentLocale;

  void changeLocale(String locale) {
    currentLocale = Locale(locale);
    notifyListeners();
  }
}
