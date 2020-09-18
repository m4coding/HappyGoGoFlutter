// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_area_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressAreaBean _$AddressAreaBeanFromJson(Map<String, dynamic> json) {
  return AddressAreaBean()
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..type = json['type'] as int;
}

Map<String, dynamic> _$AddressAreaBeanToJson(AddressAreaBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
    };
