import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/component/welcome/welcome_page.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

import 'component/home/page/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      routes: {
        WelcomePage.sName : (context) {
          return new WelcomePage();
        },
        HomePage.sName : (context) {
          return new HomePage();
        }
      },
    );
  }
}
