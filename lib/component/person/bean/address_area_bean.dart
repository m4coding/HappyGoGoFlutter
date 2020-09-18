
import 'package:json_annotation/json_annotation.dart';

part 'address_area_bean.g.dart';

///区域bean
@JsonSerializable()
class AddressAreaBean {
  String id; //地区id
  String name; //地区名称
  int type; //地区类型 1：省（包括直辖市）、2：城市、3：区、4：街道

  AddressAreaBean();

  factory AddressAreaBean.fromJson(Map<String, dynamic> json) => _$AddressAreaBeanFromJson(json);
  Map<String, dynamic> toJson() => _$AddressAreaBeanToJson(this);
}