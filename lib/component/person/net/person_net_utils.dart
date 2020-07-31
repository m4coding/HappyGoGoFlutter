
import 'dart:collection';

import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/component/person/bean/user_info_bean.dart';

class PersonNetUtils {

  ///获取用户信息
  static Future<UserInfoBean> getUserInfo() {
    Map<String, dynamic> params = HashMap();
    return httpManager.post(HttpAddress.urlGetUserInfo, params, (json) => UserInfoBean.fromJson(json)).then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }
}