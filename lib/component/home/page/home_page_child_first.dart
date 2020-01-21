import 'package:flutter/cupertino.dart';

///首页子tab-首页tab
class HomePageChildFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildFirstState();
  }

}

class _HomePageChildFirstState extends State<HomePageChildFirst> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Text("First"),);
  }

}