import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? userEmail;
  String? userName;
  String? userPhone;
  String? password;
  String? recoveryEmail;
  bool? isNotification;
  String? token;
  Timestamp? created;
  List<String>? devices;

  UserModel({
    this.id,
    this.userEmail,
    this.userName,
    this.userPhone,
    this.password,
    this.recoveryEmail,
    this.isNotification,
    this.token,
    this.created,
    this.devices,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_email': userEmail,
        'user_name': userName,
        'user_phone': userPhone,
        'password': password,
        'recovery_email': recoveryEmail,
        'is_notification': isNotification,
        'token': token,
        'created': created?.toDate().millisecondsSinceEpoch,
        'devices': devices,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        userEmail: json['user_email'],
        userName: json['user_name'],
        userPhone: json['user_phone'],
        password: json['password'],
        recoveryEmail: json['recovery_email'],
        isNotification: json['is_notification'],
        token: json['token'],
        created: json['created'] == null ? null : Timestamp.fromDate(DateTime.fromMillisecondsSinceEpoch(json['created'])),
        devices: json['devices'] == null ? [] : (json['devices'] as List).map((e) => e.toString()).toList(),
      );
}
