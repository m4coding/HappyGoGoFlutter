import 'package:flutter/cupertino.dart';

///首页子tab-个人中心tab
class HomePageChildPerson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildPersonState();
  }

}

class _HomePageChildPersonState extends State<HomePageChildPerson> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Text("Person"),);
  }

}