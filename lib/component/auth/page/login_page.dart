import 'dart:async';

import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/event/event_bus.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/component/auth/auth_page_manager.dart';
import 'package:happy_go_go_flutter/component/auth/bean/login_bean.dart';
import 'package:happy_go_go_flutter/component/auth/event/login_event.dart';
import 'package:happy_go_go_flutter/component/auth/event/register_event.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';
import 'package:happy_go_go_flutter/component/auth/net/auth_net_utils.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///登录页
class LoginPage extends StatefulWidget {
  static const String sName = "LoginPage";

  static void newInstance(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  @override
  State<StatefulWidget> createState() {
    return new _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  bool _isShowPassword = false;

  StreamSubscription _eventSubscription;

  @override
  void initState() {
    super.initState();

    _eventSubscription = eventBus.on<RegisterEvent>().listen((event) {
      if (event.type == RegisterEvent.TYPE_REGISTER_SUCCESS) {
        setState(() {
          _userController.text = event.username;
          _passwordController.text = event.password;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (_eventSubscription != null) {
      _eventSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 20,
              left: 20,
              child: GestureDetector(
                child: Icon(
                  Icons.close,
                  size: 28,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: <Widget>[
                    new Image(
                      image:
                          new AssetImage("assets/images/ic_launcher_web.png"),
                      width: 150,
                      height: 150,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _userController,
                            decoration: InputDecoration(
                              hintText: S.of(context).please_input_username,
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.secondary_text),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize: 15, color: AppColors.ff333333),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                        _userController.text.toString().isNotEmpty
                            ? GestureDetector(
                                child: Icon(
                                  Icons.cancel,
                                  color: Color(0xffdbdbdb),
                                  size: 20,
                                ),
                                onTap: () {
                                  _userController.clear();
                                  setState(() {});
                                },
                              )
                            : Container(),
                      ],
                    ),
                    Container(
                      color: AppColors.divider,
                      height: 1,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          obscureText: !_isShowPassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: S.of(context).please_input_password,
                            hintStyle: TextStyle(
                                fontSize: 15, color: AppColors.secondary_text),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 15, color: AppColors.ff333333),
                          onChanged: (value) {
                            setState(() {});
                          },
                        )),
                        _passwordController.text.toString().isNotEmpty
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.cancel,
                                    color: Color(0xffdbdbdb),
                                    size: 20,
                                  ),
                                  onTap: () {
                                    _passwordController.clear();
                                    setState(() {});
                                  },
                                ),
                              )
                            : Container(),
                        GestureDetector(
                          child: Image.asset(
                            _isShowPassword
                                ? "assets/images/login_ic_show_password.png"
                                : "assets/images/login_ic_hide_password.png",
                            width: 25,
                            height: 25,
                          ),
                          onTap: () {
                            setState(() {
                              _isShowPassword = !_isShowPassword;
                            });
                          },
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          color: AppColors.divider,
                          width: 1,
                          height: 20,
                        ),
                        Text(
                          S.of(context).forget_password,
                          style: TextStyle(
                              color: AppColors.primary_text, fontSize: 15),
                        )
                      ],
                    ),
                    Container(
                      color: AppColors.divider,
                      height: 1,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        child: Text(
                          S.of(context).new_user_register,
                          style: TextStyle(
                              color: AppColors.primary_text, fontSize: 15),
                        ),
                        onTap: () {
                          AuthPageManager.goToRegisterPage(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                    RaisedButton(
                      child: Container(
                        child: Center(
                            child: Text(
                              S.of(context).login,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                        height: 55,
                        width: double.infinity,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: AppColors.primary,
                      disabledColor: AppColors.primary_50,
                      onPressed: _userController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty
                          ? () {
                              //登录操作
                              _login();
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() {
    LoginParam loginParam = new LoginParam();
    loginParam.userName = _userController.text;
    loginParam.password = _passwordController.text;
    LoginManager.getInstance().login(loginParam).then((value) {
      if (value != null) {
          Navigator.of(context).pop();
      }
    });
  }
}
