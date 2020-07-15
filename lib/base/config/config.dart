import 'package:flutter/foundation.dart';
import 'package:happy_go_go_flutter/base/utils/local_storage_utils.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';

import 'device_and_app_info_manager.dart';

///app配置
class AppConfig {
  static bool DEBUG = !kReleaseMode; //是否为debug模式下
  static const String KEY_TOKEN = "token";

  //域名
  static String DOMAIN;

  //初始化全局信息，会在APP启动时执行
  static Future init() async {

    DOMAIN = "http://www.m4coding.xyz/happygo/fg";

    String token = await LocalStorageUtils.get(KEY_TOKEN);
    bool isLogin = false;
    if (token != null && token.isNotEmpty) {
      isLogin = true;
    }
    LoginManager.getInstance().init(isLogin, token);
    await DeviceAndAppInfoManager.init();
  }
}