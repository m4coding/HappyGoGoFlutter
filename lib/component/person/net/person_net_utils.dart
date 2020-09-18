
import 'dart:collection';

import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/component/person/bean/address_area_bean.dart';
import 'package:happy_go_go_flutter/component/person/bean/address_area_params.dart';
import 'package:happy_go_go_flutter/component/person/bean/address_params.dart';
import 'package:happy_go_go_flutter/component/person/bean/my_address_bean.dart';
import 'package:happy_go_go_flutter/component/person/bean/user_info_bean.dart';

class PersonNetUtils {

  ///获取用户信息
  static Future<UserInfoBean> getUserInfo() {
    Map<String, dynamic> params = HashMap();
    return httpManager.post(HttpAddress.urlGetUserInfo, params, (json) => UserInfoBean.fromJson(json)).then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }


  ///获取我的地址列表
  static Future<MyAddressBean> getMyAddressList() {
    Map<String, dynamic> params = HashMap();
    return httpManager.post(HttpAddress.urlGetMyAddressList, params, (json) => MyAddressBean.fromJson(json)).then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }

  ///删除地址
  static Future<bool> deleteAddress(int addressId) {
    Map<String, dynamic> params = HashMap();
    params["addressId"] = addressId;
    return httpManager.postRaw(HttpAddress.urlDeleteAddress, params).then((value) {
      if (value.isSuccess) {
        return true;
      } else {
        throw Exception(value.message);
      }
    });
  }

  ///新增地址
  static Future<AddressBean> addAddress(AddressParams addressParams) {
    Map<String, dynamic> params = HashMap();
    params.addAll(addressParams.toJson());
    return httpManager.post(HttpAddress.urlAddAddress, params, (json) => AddressBean.fromJson(json)).then((value) {
      if (value.isSuccess) {
        return value.data;
      } else {
        throw Exception(value.message);
      }
    });
  }

  ///编辑地址
  static Future<bool> editAddress(AddressParams addressParams) {
    Map<String, dynamic> params = HashMap();
    params.addAll(addressParams.toJson());
    return httpManager.postRaw(HttpAddress.urlEditAddress, params).then((value) {
      if (value.isSuccess) {
        return true;
      } else {
        throw Exception(value.message);
      }
    });
  }

  ///获取区域列表
  static Future<List<AddressAreaBean>> getAreaList(AddressAreaParams addressAreaParams) {
    Map<String, dynamic> params = HashMap();
    params.addAll(addressAreaParams.toJson());
    return httpManager.post(HttpAddress.urlGetAddressArea, params, (json) => AddressAreaBean.fromJson(json)).then((value) {
      if (value.isSuccess) {
        if (value != null && value.listData != null && value.listData.isNotEmpty) {
          return List<AddressAreaBean>.from(value.listData);
        }

        return [];
      } else {
        throw Exception(value.message);
      }
    });
  }


}