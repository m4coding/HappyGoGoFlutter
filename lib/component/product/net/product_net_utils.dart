
import 'dart:collection';

import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_bean.dart';

class ProductNetUtils {

  ///获取商品详情信息
  static Future<ProductDetailBean> getProductDetail(int productSkuId) {
    HashMap<String, dynamic> requestParams = new HashMap();
    requestParams["productSkuId"] = productSkuId;
    return HttpManager()
        .post(HttpAddress.urlGetProductDetail, requestParams,
            (json) => ProductDetailBean.fromJson(json))
        .then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }
}