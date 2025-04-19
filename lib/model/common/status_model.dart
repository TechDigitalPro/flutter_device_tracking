
class StatusModel {
  int? status;

  StatusModel({
    this.status,
  });

  Map<String, dynamic> toJson() => {
        'status': status,
      };

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        status: json['status'],
      );
}
