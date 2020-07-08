import 'package:flutter/foundation.dart';
import 'package:happy_go_go_flutter/base/utils/local_storage_utils.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';

import 'device_and_app_info_manager.dart';

///app配置
class AppConfig {
  static bool DEBUG = !kReleaseMode; //是否为debug模式下
  static const String KEY_TOKEN = "token";
  static const String KEY_USER_ID = "userId";

  //域名
  static String DOMAIN;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {

    DOMAIN = "http://www.m4coding.xyz/happygo/fg";

    String token = await LocalStorageUtils.get(KEY_TOKEN);
    int userId = await LocalStorageUtils.get(KEY_USER_ID);
    bool isLogin = false;
    if (token != null && token.isNotEmpty) {
      isLogin = true;
    }
    LoginManager.getInstance().init(isLogin, token, userId);
    await DeviceAndAppInfoManager.init();
  }
}