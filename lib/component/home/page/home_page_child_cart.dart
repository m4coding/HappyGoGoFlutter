import 'package:flutter/cupertino.dart';

///首页子tab-购物车页
class HomePageChildCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildCartState();
  }

}

class _HomePageChildCartState extends State<HomePageChildCart> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Text("Cart"),);
  }

}