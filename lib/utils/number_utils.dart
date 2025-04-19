import 'package:intl/intl.dart';

class NumberUtils {
  
  static String formattedNumberKm (double numberToFormat){
    var formattedNumber = NumberFormat.decimalPattern().format(numberToFormat);
    return formattedNumber;
  }
}