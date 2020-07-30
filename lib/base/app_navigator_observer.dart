import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/home/page/home_page.dart';

///自定义Navigator，实现无context跳转
class AppNavigatorObserver extends NavigatorObserver{
  static AppNavigatorObserver _instance;

  static final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  static AppNavigatorObserver _getInstance() {
    if (_instance == null) {
      _instance = AppNavigatorObserver();
    }
    return _instance;
  }

  static AppNavigatorObserver get instance => _getInstance();

  ///跳到首页
  void goToHomepage() {
    _instance.navigator.popUntil(
        ModalRoute.withName(HomePage.sName));
  }

}