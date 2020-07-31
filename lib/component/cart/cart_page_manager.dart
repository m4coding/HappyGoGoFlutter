
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/auth/auth_page_manager.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';
import 'package:happy_go_go_flutter/component/cart/bean/cart_page_params.dart';
import 'package:happy_go_go_flutter/component/cart/page/home_page_child_cart.dart';

class CartPageManager {

  ///跳转到购物车页面
  static void goToCartPage(BuildContext context, {CartPageParams cartPageParams}) {
    if (!LoginManager.getInstance().isLogin()) {
      AuthPageManager.goToLoginPage();
      return;
    }

    HomePageChildCart.newInstance(context, cartPageParams);
  }
}