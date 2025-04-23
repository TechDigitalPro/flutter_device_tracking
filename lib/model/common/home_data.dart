
import 'device_model.dart';

class HomeData {
  List<DeviceModel>? deviceList;

  HomeData({
    this.deviceList,
  });

  Map<String, dynamic> toJson() => {
        'mode_list': deviceList,
      };

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
        deviceList: json['mode_list'] == null 
          ? [] 
          : (json['mode_list'] as List).map((model) => DeviceModel.fromJson(model)).toList(),
      );
}
