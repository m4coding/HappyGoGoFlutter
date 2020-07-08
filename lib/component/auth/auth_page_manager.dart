
import 'package:flutter/material.dart';

import 'page/login_page.dart';

class AuthPageManager {
  static void goToLoginPage(BuildContext buildContext) {
    LoginPage.newInstance(buildContext);
  }
}