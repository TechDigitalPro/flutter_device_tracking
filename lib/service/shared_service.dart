// ignore_for_file: prefer_conditional_assignment

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/common/home_data.dart';
import '../model/common/user_model.dart';
import '../model/request/login_req.dart';

class SharedService {
  SharedPreferences? _prefs;
  _getPref() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }

    return _prefs;
  }

  Future clear() async {
    var prefs = await _getPref();
    prefs.clear();
  }

  void saveToken(String token) async {
    await _getPref();
    _prefs!.setString("token", token);
  }

  Future<String?> getToken() async {
    await _getPref();
    var token = _prefs!.getString("token");
    return token;
  }

  void saveUserId(String userId) async {
    await _getPref();
    _prefs!.setString("user_id", userId);
  }

  Future<String?> getUserId() async {
    await _getPref();
    var userId = _prefs!.getString("user_id");
    return userId;
  }

  void saveIsFirst(bool isFirst) async {
    await _getPref();
    _prefs!.setBool("isFirst", isFirst);
  }

  Future<bool> getIsFirst() async {
    await _getPref();
    var isFirst = _prefs!.getBool("isFirst");
    return isFirst ?? true;
  }

  void saveIsPro(bool isSubscription) async {
    await _getPref();
    _prefs!.setBool("subscriptoin", isSubscription);
  }

  Future<bool> getIsPro() async {
    await _getPref();
    var isSubscription = _prefs!.getBool("subscriptoin");
    return isSubscription ?? false;
  }

  void saveLoginInfo(LoginReq? loginInfo) async {
    await _getPref();
    _prefs!.setString(
      "login_info",
      loginInfo == null ? '' : jsonEncode(loginInfo.toJson()),
    );
  }

  Future<LoginReq?> getLoginInfo() async {
    await _getPref();
    String? str = _prefs!.getString("login_info");
    if (str == null || str.isEmpty) return null;
    var json = jsonDecode(str);
    LoginReq loginInfo = LoginReq.fromJson(json);
    return loginInfo;
  }

  void saveUser(UserModel? user) async {
    await _getPref();
    _prefs!.setString("user", user == null ? '' : jsonEncode(user.toJson()));
  }

  Future<UserModel?> getUser() async {
    await _getPref();
    String? str = _prefs!.getString("user");
    if (str == null || str.isEmpty) return null;
    var json = jsonDecode(str);
    UserModel userModel = UserModel.fromJson(json);
    return userModel;
  }

  void saveValue({required String name, required dynamic value}) async {
    await _getPref();
    _prefs!.setString(name, value);
  }

  Future<String?> getValue(String name) async {
    await _getPref();
    var value = _prefs!.getString(name);
    return value;
  }

  void saveHomeData(HomeData? homeData) async {
    await _getPref();
    _prefs!.setString(
      "home_data",
      homeData == null ? '' : jsonEncode(homeData.toJson()),
    );
  }

  Future<HomeData?> getHomeData() async {
    await _getPref();
    String? str = _prefs!.getString("home_data");
    if (str == null || str.isEmpty) return null;
    var json = jsonDecode(str);
    HomeData homeData = HomeData.fromJson(json);
    return homeData;
  }
}
