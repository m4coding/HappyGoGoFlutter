import 'package:flutter/cupertino.dart';
import 'package:happy_go_go_flutter/component/home/home_page_manager.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

class WelcomePage extends StatefulWidget {
  static const String sName = "/";

  @override
  State<StatefulWidget> createState() {
    return new _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage> {
  bool _hasInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_hasInit) {
      return;
    }
    _hasInit = true;

    //延时一段时间后进入其他页
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
        HomePageManager.goToHome(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: AppColors.white,
      child: new Stack(
        children: <Widget>[
          new Center(
            child: new Image(image: new AssetImage("assets/images/ic_launcher_web.png")),
          )
        ],
      ),
    );
  }
}
