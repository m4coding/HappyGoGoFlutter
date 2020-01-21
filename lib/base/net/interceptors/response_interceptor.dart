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
        value = new NetResultData(null, map["data"], map["code"],
            map["message"], map["code"] == "40001");
      }
    } catch (e) {
      print("ResponseInterceptors error=" + e.toString() + option.path);
      value = new NetResultData(null, null, Code.NETWORK_ERROR.toString(),
          '网络失败', false);
    }
    return value;
  }
}
