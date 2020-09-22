// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_receiver_address_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserReceiverAddressBean _$UserReceiverAddressBeanFromJson(
    Map<String, dynamic> json) {
  return UserReceiverAddressBean()
    ..city = json['city'] as String
    ..defaultStatus = json['defaultStatus'] as int
    ..detailAddress = json['detailAddress'] as String
    ..name = json['name'] as String
    ..phoneNumber = json['phoneNumber'] as String
    ..postCode = json['postCode'] as String
    ..province = json['province'] as String
    ..region = json['region'] as String
    ..userId = json['userId'] as int;
}

Map<String, dynamic> _$UserReceiverAddressBeanToJson(
        UserReceiverAddressBean instance) =>
    <String, dynamic>{
      'city': instance.city,
      'defaultStatus': instance.defaultStatus,
      'detailAddress': instance.detailAddress,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'postCode': instance.postCode,
      'province': instance.province,
      'region': instance.region,
      'userId': instance.userId,
    };
