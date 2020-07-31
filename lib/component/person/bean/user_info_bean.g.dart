// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoBean _$UserInfoBeanFromJson(Map<String, dynamic> json) {
  return UserInfoBean()
    ..headUrl = json['headUrl'] as String
    ..userName = json['userName'] as String
    ..userId = json['userId'] as int;
}

Map<String, dynamic> _$UserInfoBeanToJson(UserInfoBean instance) =>
    <String, dynamic>{
      'headUrl': instance.headUrl,
      'userName': instance.userName,
      'userId': instance.userId,
    };
