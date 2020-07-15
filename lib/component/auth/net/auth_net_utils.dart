
import 'dart:collection';

import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/component/auth/bean/login_bean.dart';
import 'package:happy_go_go_flutter/component/auth/bean/register_bean.dart';

///认证相关网络工具类
class AuthNetUtils {

  ///用户登录
  static Future<LoginBean> login(LoginParam loginParam) {
    Map<String, dynamic> params = HashMap();
    params["userName"] = loginParam.userName;
    params["password"] = loginParam.password;
    return httpManager
        .post(HttpAddress.urlLogin, params,
            (json) => LoginBean.fromJson(json))
        .then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }

  ///注册用户
  static Future<RegisterBean> register(RegisterParam registerParam) {
    Map<String, dynamic> params = HashMap();
    params["certificate"] = registerParam.certificate;
    params["identity"] = registerParam.identity;
    params["identityType"] = registerParam.identityType;
    return httpManager
        .post(HttpAddress.urlRegister, params,
            (json) => RegisterBean.fromJson(json))
        .then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }
}