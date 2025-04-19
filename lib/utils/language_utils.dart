import 'dart:io';

import 'package:flutter/services.dart';

class LanguageUtils {
  static const languages = ['it', 'en'];

  static String getLanguage() {
    String language = Platform.localeName.substring(0,2);
    if(languages.contains(language)){
      return language;
    } else {
      return 'en';
    }
  }

  static Future<String> checkFromResource(String name) async {
    String? loadedData = await rootBundle.loadString(name);
    return loadedData;
  }
}