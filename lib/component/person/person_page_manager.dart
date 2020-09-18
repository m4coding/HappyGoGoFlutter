
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/person/page/add_address_page.dart';
import 'package:happy_go_go_flutter/component/person/page/my_address_page.dart';

///个人页面管理器
class PersonPageManager {

  ///进入我的地址页
  static void enterMyAddressPage(BuildContext context) {
    MyAddressPage.newInstance(context);
  }

  ///进入新增地址页
  static void enterAddAddressPage(BuildContext context) {
    AddAddressPage.newInstance(context);
  }
}