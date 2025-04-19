import 'package:intl/intl.dart';

String readTimestampHH(String timestamp) {
    var format = DateFormat('hh:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000,);
    var time = '';

    time = format.format(date);

    return time;
}

String readTimestampYYYYDD(String timestamp) {
    var format = DateFormat('MMM d, yyyy');
    var date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000,);
    var dateStr = '';

    dateStr = format.format(date);

    return dateStr;
}

String readDateYYYYMMDD(DateTime dateTime){
  var format = DateFormat('yyyy/MM/dd');
  var dateStr = '';

  dateStr = format.format(dateTime);

  return dateStr;
}

String readDateYYYYMM(DateTime dateTime){
  var format = DateFormat('yyyy/MM');
  var dateStr = '';

  dateStr = format.format(dateTime);

  return dateStr;
}

String readTimestampYYYYMMDD(String timestamp){
  var format = DateFormat('yyyy/MM/dd');
  var dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000,);
  var dateStr = '';

  dateStr = format.format(dateTime);

  return dateStr;
}

String readTimestampMMMDDYYYY(String timestamp){
  int created = int.parse(timestamp) * 1000000;
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  String dateStr = dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(created));

  return dateStr;
}

String readTimestampEEEMMMDY(String timestamp){
  int created = int.parse(timestamp) * 1000000;
  final DateFormat dateFormat = DateFormat('EEEE, MMMM d, y h:mm a');
  String dateStr = dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(created));

  return dateStr;
}

String readTimestampEEE(String timestamp){
  int created = int.parse(timestamp) * 1000000;
  final DateFormat dateFormat = DateFormat('EEE');
  String dateStr = dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(created));

  return dateStr;
}

String readTimestampMMMDHMMA(String timestamp){
  int created = int.parse(timestamp) * 1000000;
  final DateFormat dateFormat = DateFormat('MMM d h:mm a');
  String dateStr = dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(created));

  return dateStr;
}

String readTimestampMMMD(String timestamp){
  int created = int.parse(timestamp) * 1000000;
  final DateFormat dateFormat = DateFormat('MMM d');
  String dateStr = dateFormat.format(DateTime.fromMicrosecondsSinceEpoch(created));

  return dateStr;
}

String currentTimestampMMMDDYYYY(){
  var now = DateTime.now();
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  String dateStr = dateFormat.format(now);

  return dateStr;
}

String formatDate(String curDate){
  final DateFormat dateFormatCur = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime date = dateFormatCur.parse(curDate);

  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  String dateStr = dateFormat.format(date);

  return dateStr;
}

String formatDateToMMMDDYYYYFromMMDDYYYY(String curDate){
  final DateFormat dateFormatCur = DateFormat('MM-dd-yyyy');
  DateTime date = dateFormatCur.parse(curDate);
  
  final DateFormat dateFormat = DateFormat('MMM dd, yyyy');
  String dateStr = dateFormat.format(date);

  return dateStr;
}

String formatDateToMMDDYYYY(String curDate){
  final DateFormat dateFormatCur = DateFormat('MMM dd, yyyy');
  DateTime date = dateFormatCur.parse(curDate);
  
  final DateFormat dateFormat = DateFormat('MM-dd-yyyy');
  String dateStr = dateFormat.format(date);

  return dateStr;
}

String formatDateToYYYYMMDD1(String curDate){
  final DateFormat dateFormatCur = DateFormat('MMM dd, yyyy');
  DateTime date = dateFormatCur.parse(curDate);
  
  final DateFormat dateFormat = DateFormat('yyyy/MM/dd');
  String dateStr = dateFormat.format(date);

  return dateStr;
}

String formatDateToYYYYMMDD2(String curDate){
  final DateFormat dateFormatCur = DateFormat('MMM dd, yyyy');
  DateTime date = dateFormatCur.parse(curDate);
  
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  String dateStr = dateFormat.format(date);

  return dateStr;
}

DateTime dateFromYYYYMMDDStr(String curDate){
  final DateFormat dateFormatCur = DateFormat('yyyy-MM-dd HH:mm');
  DateTime date = dateFormatCur.parse(curDate);

  return date;
}

DateTime dateFromYYYYMMDDHourStr(String curDate){
  final DateFormat dateFormatCur = DateFormat('yyyy-MM-dd HH:mm:ss');
  DateTime date = dateFormatCur.parse(curDate);

  return date;
}

String formatNumberAsMonth(String month){
  String monthStr = '';
  switch(month){
    case '1' : monthStr = 'JAN'; break;
    case '2' : monthStr = 'FEB'; break;
    case '3' : monthStr = 'MAR'; break;
    case '4' : monthStr = 'APR'; break;
    case '5' : monthStr = 'MAY'; break;
    case '6' : monthStr = 'JUN'; break;
    case '7' : monthStr = 'JUL'; break;
    case '8' : monthStr = 'AUG'; break;
    case '9' : monthStr = 'SEP'; break;
    case '10' : monthStr = 'OCT'; break;
    case '11' : monthStr = 'NOV'; break;
    case '12' : monthStr = 'DEC'; break;
  }

  return monthStr;
}