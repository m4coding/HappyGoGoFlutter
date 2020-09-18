
import 'package:json_annotation/json_annotation.dart';

part 'address_area_params.g.dart';

///获取区域列表参数
@JsonSerializable()
class AddressAreaParams {
  String areaCode;

  AddressAreaParams();

  factory AddressAreaParams.fromJson(Map<String, dynamic> json) => _$AddressAreaParamsFromJson(json);
  Map<String, dynamic> toJson() => _$AddressAreaParamsToJson(this);
}