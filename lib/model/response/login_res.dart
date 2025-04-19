import '../common/status_model.dart';

class LoginRes {
  String? token;
  String? userEmail;
  String? userNiceName;
  String? userDisplayName;
  String? userId;
  // Response Error
  StatusModel? data;
  String? code;
  String? message;

  LoginRes({
    this.token,
    this.userEmail,
    this.userNiceName,
    this.userDisplayName,
    this.userId,
    // Response Error
    this.data,
    this.code,
    this.message,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'user_email': userEmail,
        'user_nicename': userNiceName,
        'user_display_name': userDisplayName,
        'user_id': userId,
        // Response Error
        'data': data?.toJson(),
        'code': code,
        'message': message,
      };

  factory LoginRes.fromJson(Map<String, dynamic> json) => LoginRes(
        token: json['token'],
        userEmail: json['user_email'],
        userNiceName: json['user_nicename'],
        userDisplayName: json['user_display_name'],
        userId: json['user_id'],
        // Response Error
        data: json['data'] == null ? null : StatusModel.fromJson(json['data']),
        code: json['code'],
        message: json['message'],
      );
}
