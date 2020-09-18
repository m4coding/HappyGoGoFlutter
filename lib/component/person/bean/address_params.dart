
import 'package:json_annotation/json_annotation.dart';

part 'address_params.g.dart';

///地址入参
@JsonSerializable()
class AddressParams {
  int addressId; //地址id, 编辑地址时需要用到，添加地址不需要
  int isDefault; //是否默认地址，0-不是 1-是
  String receiverAddr; //收货详细地址
  String receiverName; //收货人名字
  String receiverPhone; //收货人手机号
  String receiverRegion; //收货人地区

  AddressParams();

  factory AddressParams.fromJson(Map<String, dynamic> json) => _$AddressParamsFromJson(json);
  Map<String, dynamic> toJson() => _$AddressParamsToJson(this);

}