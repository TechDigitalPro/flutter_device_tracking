import 'package:flutter/material.dart';

class ColorUtils {
  static Color appColorPrimaryDark = const Color(0xFF041530);
  static Color appColorPrimary = const Color(0xFF041530);
  static Color appColorAccent = const Color(0xFF041530);
  static Color appColorBlue = const Color(0xFF0075F8);
  static Color appColorBlueDark = const Color(0xFF002248);
  static Color appColorBlueLight = const Color(0xFF00ACEE);

  static Color appColorYellow = const Color(0xFFFFD89F);
  static Color appColorRed = const Color(0xFFE0294C);
  static Color appColorMenu = const Color(0xFF2E2E2E);
  static Color appColorTextWhite = const Color(0xFFCFCFCF);
  static Color appColorCard = const Color(0xFF323232);
  static Color appColorMain = const Color(0xFF1E1E1E);
  static Color appColorGreyLine = const Color(0x80545454);
  static Color appColorGreyLight = const Color(0xFFC5C5C5);
  static Color appColorGreyDark = const Color(0xFF565656);

  static Color appColorAccent_10 = const Color(0x1A00ACEE);
  static Color appColorAccent_5 = const Color(0x0500ACEE);
  static Color appColorAccent_50 = const Color(0x8000ACEE);
  static Color appColorBlack = const Color(0xFF000000);
  static Color appColorBlack_10 = const Color(0x1A000000);
  static Color appColorBlack_30 = const Color(0x4D000000);
  static Color appColorBlack_50 = const Color(0x80000000);
  static Color appColorOrange_10 = const Color(0x1AFFA800);
  static Color appColorWhite = const Color(0xFFFFFFFF);
  static Color appColorWhite_20 = const Color(0x33FFFFFF);
  static Color appColorWhite_50 = const Color(0x80FFFFFF);
  static Color appColorWhite_80 = const Color(0xCCFFFFFF);
  static Color appColorWhite_5 = const Color(0x15FFFFFF);
  static Color appColorBlueMain = const Color(0xFF0C33F8);
  static Color appColorRedDark = const Color(0xFFFF3333);
  static Color appColorTransparent = const Color(0x00FFFFFF);
  static Color appColorTextTitle = const Color(0xFF4A4D61);
  static Color appColorTextDark = const Color(0xFF1B1B1B);
  static Color appColorTextLight = const Color(0xFF898989);
  static Color appColorGreyWhite = const Color(0xFFEEEEEE);
  static Color appColorGreyBack = const Color(0xFFEEEEEE);
  static Color appColorGradientEnd = const Color(0x88100400);
  static Color appColorGradientStart = const Color(0x00100400);
  static Color appColorGreen = const Color(0xFF00FFA2);

  static Color appColorCardRed = const Color(0xFFE44C4C);
  static Color appColorCardBlue = const Color(0xFF275485);
  static Color appColorCardBlueLight = const Color(0xFF5840E4);
  static Color appColorCardGreenDark = const Color(0xFF42a78a);
  static Color appColorCardYellow = const Color(0xFFf0cc4f);
  static Color appColorCardPurple = const Color(0xFF8c4ff0);
  static Color appColorCardOrange = const Color(0xFFe99340);
  static Color appColorCardGreenLight = const Color(0xFF00FFA2);
  static Color appColorCardBrown = const Color(0xFFb85c03);

  static int hexToInt(String hex)
  {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        val = 0;
      }
    }
    return val;
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static String colorToHex(Color color) {
    return '#${(color.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
  }
}
