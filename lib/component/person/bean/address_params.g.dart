// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressParams _$AddressParamsFromJson(Map<String, dynamic> json) {
  return AddressParams()
    ..addressId = json['addressId'] as int
    ..isDefault = json['isDefault'] as int
    ..receiverAddr = json['receiverAddr'] as String
    ..receiverName = json['receiverName'] as String
    ..receiverPhone = json['receiverPhone'] as String
    ..receiverRegion = json['receiverRegion'] as String;
}

Map<String, dynamic> _$AddressParamsToJson(AddressParams instance) =>
    <String, dynamic>{
      'addressId': instance.addressId,
      'isDefault': instance.isDefault,
      'receiverAddr': instance.receiverAddr,
      'receiverName': instance.receiverName,
      'receiverPhone': instance.receiverPhone,
      'receiverRegion': instance.receiverRegion,
    };
