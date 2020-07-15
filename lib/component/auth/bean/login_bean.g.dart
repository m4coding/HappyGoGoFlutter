// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBean _$LoginBeanFromJson(Map<String, dynamic> json) {
  return LoginBean()
    ..token = json['token'] as String
    ..tokenHead = json['tokenHead'] as String;
}

Map<String, dynamic> _$LoginBeanToJson(LoginBean instance) => <String, dynamic>{
      'token': instance.token,
      'tokenHead': instance.tokenHead,
    };
