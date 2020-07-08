import 'package:flutter/cupertino.dart';

///首页子tab-购物车页
class HomePageChildCart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildCartState();
  }

}

class _HomePageChildCartState extends State<HomePageChildCart>  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new Container(child: Center(child: Text("Cart")),);
  }

  @override
  bool get wantKeepAlive => true;

}