import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:happy_go_go_flutter/base/app_navigator_observer.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/component/auth/auth_page_manager.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';

import '../code.dart';
import '../net_result_data.dart';

/// 响应拦截器
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    var value;
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = response.data;
        NetResultData netResultData = new NetResultData(null, null, map["code"], map["message"], map["code"] == 20000, otherData: null);
        if (map["data"] is Map) {
          netResultData.data = map["data"];
        } else if (map["data"] is List) {
          netResultData.listData = map["data"];
        } else { //其他类型数据
          netResultData.otherData = map["data"];
        }

        value = netResultData;

        _parseCode(map["code"]);
      }
    } catch (e) {
      logger.d("ResponseInterceptors error=##" + e.toString() + "##  path=" + option.path);
      value = new NetResultData(null, null, Code.NETWORK_ERROR,
          '网络失败', false);
    }
    return value;
  }

  void _parseCode(int code) {
    switch(code) {
      case 20401:
        logger.d("http 20401 go to login");
        LoginManager.getInstance().logout();
        AppNavigatorObserver.instance.goToHomepage();
        AuthPageManager.goToLoginPage();
        break;
    }
  }
}
