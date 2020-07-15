import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/event/event_bus.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/bar/common_bar.dart';
import 'package:happy_go_go_flutter/component/auth/bean/register_bean.dart';
import 'package:happy_go_go_flutter/component/auth/event/login_event.dart';
import 'package:happy_go_go_flutter/component/auth/event/register_event.dart';
import 'package:happy_go_go_flutter/component/auth/net/auth_net_utils.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///注册页面
class RegisterPage extends StatefulWidget {
  static const String sName = "LoginPage";

  static void newInstance(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return RegisterPage();
    }));
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _confirmPasswordController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBar(
        title: S.of(context).register_user,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 25, right: 25, top: 30),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      hintText: S.of(context).please_input_username,
                      hintStyle: TextStyle(
                          fontSize: 15, color: AppColors.secondary_text),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15, color: AppColors.ff333333),
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
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: S.of(context).please_input_password,
                      hintStyle: TextStyle(
                          fontSize: 15, color: AppColors.secondary_text),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15, color: AppColors.ff333333),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                _passwordController.text.toString().isNotEmpty
                    ? GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Color(0xffdbdbdb),
                          size: 20,
                        ),
                        onTap: () {
                          _passwordController.clear();
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
                    obscureText: true,
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: S.of(context).please_again_confirm_password,
                      hintStyle: TextStyle(
                          fontSize: 15, color: AppColors.secondary_text),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 15, color: AppColors.ff333333),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                _confirmPasswordController.text.toString().isNotEmpty
                    ? GestureDetector(
                        child: Icon(
                          Icons.cancel,
                          color: Color(0xffdbdbdb),
                          size: 20,
                        ),
                        onTap: () {
                          _confirmPasswordController.clear();
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
              padding: EdgeInsets.only(top: 30),
            ),
            RaisedButton(
              child: Container(
                child: Center(
                    child: Text(
                      S.of(context).register,
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
                      _passwordController.text.isNotEmpty &&
                      _confirmPasswordController.text.isNotEmpty
                  ? () {
                      _register();
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  //注册
  void _register() {

    if (_passwordController.text != _confirmPasswordController.text) {
      ToastUtils.show("确认的密码不一致");
      return;
    }

    RegisterParam registerParam = new RegisterParam();
    registerParam.identityType = "admin";
    registerParam.certificate = _passwordController.text; //密码
    registerParam.identity = _userController.text; //账号
    AuthNetUtils.register(registerParam).then((value) {
      ToastUtils.show("注册成功");
      //发送注册成功事件
      eventBus.fire(RegisterEvent(RegisterEvent.TYPE_REGISTER_SUCCESS, username: registerParam.identity, password: registerParam.certificate));
      Navigator.pop(context);
    }).catchError((onError){
      ToastUtils.show(onError.toString());
    });
  }
}
