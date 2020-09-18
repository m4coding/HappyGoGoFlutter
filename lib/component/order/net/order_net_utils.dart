
import 'dart:collection';

import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/component/order/bean/confirm_order_info_bean.dart';
import 'package:happy_go_go_flutter/component/order/bean/confirm_order_params.dart';

///订单相关网络操作工具类
class OrderNetUtils {

  ///获取确认订单信息
  static Future<ConfirmOrderInfoBean> getConfirmOrderInfo(ConfirmOrderParams confirmOrderParams) {
    Map<String, dynamic> params = HashMap();

    List<Map> mapList = [];
    for (ConfirmOrderProductParams params in confirmOrderParams.productList) {
      Map map = HashMap();
      map["productSkuId"] = params.productSkuId;
      map["quantity"] = params.quantity;
      mapList.add(map);
    }

    params["productList"] = mapList;

    return httpManager.post(HttpAddress.urlGetConfirmOrderInfo, params, (json) => ConfirmOrderInfoBean.fromJson(json)).then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }
}