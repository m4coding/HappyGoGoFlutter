import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:happy_go_go_flutter/base/utils/local_storage_utils.dart';

import '../../config.dart';

/**
 * Token拦截器
 */
class TokenInterceptors extends InterceptorsWrapper {
  String _token;

  @override
  onRequest(RequestOptions options) async {
    //授权码
    if (_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
      }
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
    try {
      if (response.request.path.contains("ysb-user/api/auth/appLogin")) { //判断是否是登录url
        if (response.statusCode == 200 && response.data["code"] == "40001") {
          _token = response.data["data"]["token"]; //取出token并保存
          await LocalStorageUtils.save(Config.TOKEN_KEY, _token);
        }
      }
    } catch (e) {
      print(e);
    }
    return response;
  }

  ///清除授权
  clearAuthorization() {
    this._token = null;
    LocalStorageUtils.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String token = await LocalStorageUtils.get(Config.TOKEN_KEY);
    if (token == null) {
      //提示输入账号密码
    } else {
      this._token = token;
    }

    return token;
  }
}
