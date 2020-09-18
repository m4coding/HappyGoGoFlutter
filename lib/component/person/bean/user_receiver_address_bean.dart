
import 'package:json_annotation/json_annotation.dart';

part 'user_receiver_address_bean.g.dart';

///收货人地址
@JsonSerializable()
class UserReceiverAddressBean {
  String city;
  int defaultStatus; //是否为默认 1为默认，0不是
  String detailAddress; //详细地址(街道)
  String name; //收货人名称
  String phoneNumber; //电话号码
  String postCode; //邮政编码
  String province; //省份/直辖市
  String region; //区
  String userId; //用户id

  UserReceiverAddressBean();

  factory UserReceiverAddressBean.fromJson(Map<String, dynamic> json) => _$UserReceiverAddressBeanFromJson(json);
  Map<String, dynamic> toJson() => _$UserReceiverAddressBeanToJson(this);
}