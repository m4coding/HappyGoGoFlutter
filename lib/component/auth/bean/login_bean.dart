
import 'package:json_annotation/json_annotation.dart';

part 'login_bean.g.dart';

///登录bean
@JsonSerializable()
class LoginBean {
  String token;
  String tokenHead;

  LoginBean();

  factory LoginBean.fromJson(Map<String, dynamic> json) => _$LoginBeanFromJson(json);
  Map<String, dynamic> toJson() => _$LoginBeanToJson(this);
}

///登录入参
class LoginParam {
  String password; //密码
  String userName; //用户名
}