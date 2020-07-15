
import 'package:json_annotation/json_annotation.dart';

part 'register_bean.g.dart';

///注册结果bean
@JsonSerializable()
class RegisterBean {
  int status; //用户状态 1表示启用状态，0表示禁用状态
  int userId; //用户ID
  String userName; //用户名

  RegisterBean();

  factory RegisterBean.fromJson(Map<String, dynamic> json) => _$RegisterBeanFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterBeanToJson(this);
}

///注册入参
class RegisterParam {
  String certificate; //授权凭证 如：登录账号对应的是密码、第三方登录对应的是token
  String identity; //识别标识 如：登录账号、邮箱地址、手机号、微信号、qq号等
  String identityType; //登录类型 如：admin表示系统用户，phone表示手机登录，weixin表示微信登录，qq表示qq登录
}

