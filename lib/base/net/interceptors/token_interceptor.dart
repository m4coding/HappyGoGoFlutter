import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:happy_go_go_flutter/base/utils/local_storage_utils.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';

import '../../config/config.dart';

/// Token拦截器
class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    if (_token == null) {
       _token = _getAuthorization();
    }


    if (_token != null && options.data is String) {
      Map<String, dynamic> map = json.decode(options.data);
      map["usertoken"] = _token;
      options.data = json.encode(map);
    }

    return options;
  }

  @override
  onResponse(Response response) async {
    return response;
  }

  ///获取授权token
  _getAuthorization() {
    String token = LoginManager.getInstance().getToken();
    return token;
  }
}
