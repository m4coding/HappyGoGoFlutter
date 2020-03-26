import 'package:dio/dio.dart';
import 'dart:collection';

import 'code.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/response_interceptor.dart';
import 'interceptors/token_interceptor.dart';
import 'net_result_data.dart';

///http请求
class HttpManager {
  static const CONTENT_TYPE_JSON = "application/json";
  static const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

  Dio _dio = new Dio(); // 使用默认配置

  final TokenInterceptors _tokenInterceptors = new TokenInterceptors();

  HttpManager() {
    //添加对应的拦截器
    _dio.interceptors.add(new HeaderInterceptors());

    _dio.interceptors.add(_tokenInterceptors);

    _dio.interceptors.add(new LogsInterceptors());

    _dio.interceptors.add(new ErrorInterceptors(_dio));

    _dio.interceptors.add(new ResponseInterceptors());
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  ///[ header] 外加头
  ///[ option] 配置
  Future<NetResultData> _netFetch(
      url, Map<String, dynamic> params, {Map<String, dynamic> header, Options option}) async {
    Map<String, dynamic> headers = new HashMap();
    if (header != null) {
      headers.addAll(header);
    }

    if (option != null) {
      option.headers = headers;
    } else {
      option = new Options(method: "get");
      option.headers = headers;
    }

    //内部定义一个方法。。
    resultError(DioError e) {
      return new NetResultData(null, null, Code.NETWORK_ERROR, e.message, false);
    }

    Response response;
    try {
      response = await _dio.request(url, data: params, options: option);
    } on DioError catch (e) {
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data);
    }

    return response.data;
  }

  ///post
  Future<NetResultProcessData> post(String url, Map<String, dynamic> params, Object transform(Map<String, dynamic> json)) {
    return _getTransform(_netFetch(url, params, option: new Options(method: "post")), transform);
  }

  ///post  返回的内容不经过转换
  Future<NetResultData> postRaw(String url, Map<String, dynamic> params) {
    return _netFetch(url, params, option: new Options(method: "post"));
  }

  ///get
  get(String url, Map<String, dynamic> params, Object transform(Map<String, dynamic> json)) {
    return _getTransform(_netFetch(url, params, option: new Options(method: "get")), transform);
  }

  ///post  返回的内容不经过转换
  Future<NetResultData> getRaw(String url, Map<String, dynamic> params) {
    return _netFetch(url, params, option: new Options(method: "get"));
  }

  //转换处理 to bean
  Future<NetResultProcessData> _getTransform(Future<NetResultData> future, Object transform(Map<String, dynamic> json)) {
    return future.then((NetResultData netResultData){
      //有map数据时
      if (netResultData.data != null) {
        return NetResultProcessData(
            null,
            netResultData.data != null ? transform(netResultData.data) : null,
            netResultData.code, netResultData.message, netResultData.isSuccess);
      }

      //有list数据时
      if (netResultData.listData != null) {
        List list = [];
        for (Map map in netResultData.listData) {
          list.add(transform(map));
        }
        return NetResultProcessData(list, null, netResultData.code, netResultData.message, netResultData.isSuccess);
      }

      //map和list数据都没有时
      return NetResultProcessData(null, null, netResultData.code, netResultData.message, netResultData.isSuccess);
    });
  }

  ///清除授权
  clearAuthorization() {
    _tokenInterceptors.clearAuthorization();
  }

  ///获取授权token
  getAuthorization() async {
    return _tokenInterceptors.getAuthorization();
  }
}

final HttpManager httpManager = new HttpManager();
