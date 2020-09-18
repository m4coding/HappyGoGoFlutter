
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/order/bean/confirm_order_params.dart';
import 'package:happy_go_go_flutter/component/order/page/confirm_order_page.dart';

///订单页面入口管理器
class OrderPageManager {

  static void enterConfirmOrderPage(BuildContext context, ConfirmOrderParams confirmOrderParams) {
    ConfirmOrderPage.newInstance(context, confirmOrderParams);
  }
}