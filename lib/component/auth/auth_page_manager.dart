
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/auth/page/register_page.dart';

import 'page/login_page.dart';

class AuthPageManager {
  static void goToLoginPage(BuildContext buildContext) {
    LoginPage.newInstance(buildContext);
  }


  static void goToRegisterPage(BuildContext buildContext) {
    RegisterPage.newInstance(buildContext);
  }
}