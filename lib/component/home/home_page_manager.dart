import 'package:flutter/cupertino.dart';
import 'package:happy_go_go_flutter/component/home/page/home_page.dart';

class HomePageManager {
  static void goToHome(BuildContext buildContext) {
    Navigator.pushReplacementNamed(buildContext, HomePage.sName);
  }
}