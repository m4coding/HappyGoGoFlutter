
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/auth/auth_page_manager.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_param.dart';
import 'package:happy_go_go_flutter/component/product/page/product_detail_page.dart';

///商品管理器
class ProductManager {

  ///跳转到商品详情页
  static void goToProductDetail(BuildContext context, ProductDetailParam productDetailParam) {

    if (!LoginManager.getInstance().isLogin()) {
      AuthPageManager.goToLoginPage();
      return;
    }

    ProductDetailPage.newInstance(context, productDetailParam);
  }

}