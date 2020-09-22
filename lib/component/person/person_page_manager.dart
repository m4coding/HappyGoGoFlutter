
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/person/page/add_address_page.dart';
import 'package:happy_go_go_flutter/component/person/page/my_address_page.dart';

import 'bean/my_address_bean.dart';

///个人页面管理器
class PersonPageManager {

  ///进入我的地址页
  static Future<AddressBean> enterMyAddressPage(BuildContext context) {
    return MyAddressPage.newInstance(context);
  }

  ///进入新增地址页
  ///isAdd true表示新增， false表示编辑
  static Future<bool> enterAddAddressPage(BuildContext context, {AddressBean addressBean}) {
    return AddAddressPage.newInstance(context, addressBean);
  }
}