import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happy_go_go_flutter/component/welcome/welcome_page.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

import 'base/config/config.dart';
import 'component/home/page/home_page.dart';

void main() {
  // If you're running an application and need to access the binary messenger before
  // `runApp()` has been called (for example, during plugin initialization),
  // then you need to explicitly call the `WidgetsFlutterBinding.ensureInitialized()` first.
  WidgetsFlutterBinding.ensureInitialized();
  AppConfig.init().then((e) {
    runApp(MyApp());
  }).catchError((e) {
    print("AppConfig init error, MyApp can not new");
    print(e.toString());
  });

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前
    // MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      // 讲en设置为第一项,没有适配语言时,英语为首选项
      supportedLocales: S.delegate.supportedLocales,
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
