
import 'dart:collection';

import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/base/net/net_result_data.dart';
import 'package:happy_go_go_flutter/component/cart/bean/cart_info_bean.dart';
import 'package:happy_go_go_flutter/component/cart/bean/cart_update_params.dart';

///购物车网络工具类
class CartNetUtils {

  static Future<NetResultData> addCart(int productSkuId, int quantity) {
    HashMap<String, dynamic> requestParams = new HashMap();
    requestParams["productSkuId"] = productSkuId;
    requestParams["quantity"] = quantity;
    return HttpManager()
        .postRaw(HttpAddress.urlAddCart, requestParams)
        .then((value) {
      if (value.isSuccess) {
        return value;
      } else {
        throw Exception(value.message);
      }
    });
  }

  static Future<NetResultData> deleteFromCart(List<int> productSkuId) {
    HashMap<String, dynamic> requestParams = new HashMap();
    requestParams["productSkuIds"] = productSkuId;
    return HttpManager()
        .postRaw(HttpAddress.urlDeleteFromCart, requestParams)
        .then((value) {
      if (value.isSuccess) {
        return value;
      } else {
        throw Exception(value.message);
      }
    });
  }

  static Future<NetResultData> getCartCount() {
    HashMap<String, dynamic> requestParams = new HashMap();
    return HttpManager()
        .postRaw(HttpAddress.urlGetCartCount, requestParams)
        .then((value) {
      if (value.isSuccess) {
        return value;
      } else {
        throw Exception(value.message);
      }
    });
  }

  ///获取购物车信息
  static Future<CartInfoBean> getCartInfo() {
    HashMap<String, dynamic> requestParams = new HashMap();
    return HttpManager()
        .post(HttpAddress.urlGetCartInfo, requestParams, (json) => CartInfoBean.fromJson(json))
        .then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }

  ///更新购物车信息
  static Future<NetResultData> updateCartInfo(List<CartUpdateParams> list) {
    HashMap<String, dynamic> requestParams = new HashMap();

    List<Map> mapList = [];
    for (CartUpdateParams params in list) {
      mapList.add(params.toJson());
    }
    requestParams["productList"] = mapList;

    return HttpManager()
        .postRaw(HttpAddress.urlUpdateCartInfo , requestParams)
        .then((value) {
      if (value.isSuccess) {
        return value;
      } else {
        throw Exception(value.message);
      }
    });
  }
}