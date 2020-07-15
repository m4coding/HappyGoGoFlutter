// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterBean _$RegisterBeanFromJson(Map<String, dynamic> json) {
  return RegisterBean()
    ..status = json['status'] as int
    ..userId = json['userId'] as int
    ..userName = json['userName'] as String;
}

Map<String, dynamic> _$RegisterBeanToJson(RegisterBean instance) =>
    <String, dynamic>{
      'status': instance.status,
      'userId': instance.userId,
      'userName': instance.userName,
    };
