import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceModel {
  String? id;
  String? description;
  String? status;
  String? name;
  Timestamp? created;

  DeviceModel({
    this.id,
    this.description,
    this.status,
    this.name,
    this.created,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'status': status,
        'name': name,
        'created': created?.toDate().millisecondsSinceEpoch,
      };

  factory DeviceModel.fromJson(Map<String, dynamic> json) => DeviceModel(
        id: json['id'],
        description: json['description'],
        status: json['status'],
        name: json['name'],
        created: json['created'] == null ? null : Timestamp.fromDate(DateTime.fromMillisecondsSinceEpoch(json['created'])),
      );
}
