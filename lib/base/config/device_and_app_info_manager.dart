import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

///获取设备相关信息、app相关信息
class DeviceAndAppInfoManager {

  static DeviceAndAppInfoManager _instance;

  static IosDeviceInfo _iosDeviceInfo;
  static AndroidDeviceInfo _androidDeviceInfo;
  static PackageInfo _packageInfo;

  static DeviceAndAppInfoManager _getInstance() {
    if (_instance == null) {
      _instance = new DeviceAndAppInfoManager._();
    }

    return _instance;
  }

  static DeviceAndAppInfoManager get instance => _getInstance();

  ///初始化
  static void init() async {
    DeviceInfoPlugin deviceInfo = new DeviceInfoPlugin();
    if(Platform.isIOS){
      _iosDeviceInfo = await deviceInfo.iosInfo;
    }else if(Platform.isAndroid){
      _androidDeviceInfo = await deviceInfo.androidInfo;
    }

    _packageInfo = await PackageInfo.fromPlatform();
  }

  DeviceAndAppInfoManager._();

  Future<String> getOs() async {
    if (Platform.isIOS) {
      return "ios";
    } else if (Platform.isAndroid) {
      return "android";
    }

    return "";
  }

  Future<String> getVersionName() async {
    return _packageInfo.version;
  }

  Future<int> getVersionCode() async {
    return int.parse(_packageInfo.buildNumber);
  }

  Future<String> getDeviceId() async {
    if (Platform.isIOS) {
      return _iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      return _androidDeviceInfo.androidId;
    }

    return "";
  }
}