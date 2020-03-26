import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import '../code.dart';
import '../net_result_data.dart';

///是否需要弹提示
const NOT_TIP_KEY = "noTip";

///错误拦截
class ErrorInterceptors extends InterceptorsWrapper {
  final Dio _dio;

  ErrorInterceptors(this._dio);

  @override
  onRequest(RequestOptions options) async {

    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) { //没有网络
      return _dio.resolve(new NetResultData(null, null, Code.NETWORK_ERROR,
          '网络失败',false));
    }
    return options;
  }
}
