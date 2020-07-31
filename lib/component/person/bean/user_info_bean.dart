
import 'package:json_annotation/json_annotation.dart';

part 'user_info_bean.g.dart';

///个人信息Bean
@JsonSerializable()
class UserInfoBean {
  String headUrl;
  String userName;
  int userId;

  UserInfoBean();

  factory UserInfoBean.fromJson(Map<String, dynamic> json) => _$UserInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoBeanToJson(this);
}