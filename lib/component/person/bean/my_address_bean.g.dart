// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_address_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAddressBean _$MyAddressBeanFromJson(Map<String, dynamic> json) {
  return MyAddressBean()
    ..addressList = (json['addressList'] as List)
        ?.map((e) =>
            e == null ? null : AddressBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MyAddressBeanToJson(MyAddressBean instance) =>
    <String, dynamic>{
      'addressList': instance.addressList,
    };

AddressBean _$AddressBeanFromJson(Map<String, dynamic> json) {
  return AddressBean()
    ..isDefault = json['isDefault'] as int
    ..receiverAddr = json['receiverAddr'] as String
    ..receiverName = json['receiverName'] as String
    ..receiverPhone = json['receiverPhone'] as String
    ..receiverRegion = json['receiverRegion'] as String;
}

Map<String, dynamic> _$AddressBeanToJson(AddressBean instance) =>
    <String, dynamic>{
      'isDefault': instance.isDefault,
      'receiverAddr': instance.receiverAddr,
      'receiverName': instance.receiverName,
      'receiverPhone': instance.receiverPhone,
      'receiverRegion': instance.receiverRegion,
    };
