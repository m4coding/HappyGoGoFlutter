
import 'package:json_annotation/json_annotation.dart';

part 'my_address_bean.g.dart';

///我的地址列表bean
@JsonSerializable()
class MyAddressBean {
  List<AddressBean> addressList; //地址列表

  MyAddressBean();

  factory MyAddressBean.fromJson(Map<String, dynamic> json) => _$MyAddressBeanFromJson(json);
  Map<String, dynamic> toJson() => _$MyAddressBeanToJson(this);
}

@JsonSerializable()
class AddressBean {
  int isDefault; //是否默认地址，0-不是 1-是
  String receiverAddr; //收货详细地址
  String receiverName; //收货人名字
  String receiverPhone; //收货人手机号
  String receiverRegion; //收货人地区

  AddressBean();

  factory AddressBean.fromJson(Map<String, dynamic> json) => _$AddressBeanFromJson(json);
  Map<String, dynamic> toJson() => _$AddressBeanToJson(this);
}