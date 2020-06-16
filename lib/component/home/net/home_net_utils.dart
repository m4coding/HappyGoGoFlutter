import 'dart:collection';

import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/component/home/bean/category_bean.dart';
import 'package:happy_go_go_flutter/component/home/bean/home_product_item.dart';

///首页相关的网络工具
class HomeNetUtils {
  ///获取分类列表
  static Future<CategoryBean> getCategoryList(int pageNum, int pageSize,
      {bool isRootCategory, String keyword}) {
    Map<String, dynamic> params = HashMap();
    params["pageNum"] = pageNum;
    params["pageSize"] = pageSize;
    if (isRootCategory != null) {
      params["isRootCategory"] = isRootCategory;
    }
    if (keyword != null) {
      params["keyword"] = keyword;
    }
    return httpManager
        .post(HttpAddress.urlGetCategoryList, params,
            (json) => CategoryBean.fromJson(json))
        .then((value) {
      if (value.isSuccess) {
        return value.data;
      }
      {
        throw Exception(value.message);
      }
    });
  }

  ///获取商品列表信息
  ///tabType为分类id
  static Future<ProductPageBean> getPageListInfo(
      int pageNum, int pageSize, int tabType) {
    HashMap<String, dynamic> requestParams = new HashMap();
    requestParams["pageSize"] = pageSize;
    requestParams["pageNum"] = pageNum;
    requestParams["tabType"] = tabType;
    return HttpManager()
        .post(HttpAddress.urlGetPageListInfo, requestParams,
            (json) => ProductPageBean.fromJson(json))
        .then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }
}
