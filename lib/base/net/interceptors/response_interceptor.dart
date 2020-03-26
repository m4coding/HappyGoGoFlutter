import 'dart:convert';

import 'package:dio/dio.dart';

import '../code.dart';
import '../net_result_data.dart';

/**
 * Token拦截器
 */
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    var value;
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> map = response.data;
        if (map["data"] is Map) {
          value = new NetResultData(null, map["data"], map["code"],
              map["message"], map["code"] == 20000);
        } else if (map["data"] is List) {
          value = new NetResultData(map["data"], null, map["code"],
              map["message"], map["code"] == 20000);
        } else if (map["data"] == null) {
          value = new NetResultData(null, null, map["code"],
              map["message"], map["code"] == 20000);
        }
      }
    } catch (e) {
      print("ResponseInterceptors error=##" + e.toString() + "##  path=" + option.path);
      value = new NetResultData(null, null, Code.NETWORK_ERROR,
          '网络失败', false);
    }
    return value;
  }
}
