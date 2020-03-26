import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/widgets/tabbar_widget.dart';
import 'package:happy_go_go_flutter/component/home/page/home_page_child_cart.dart';
import 'package:happy_go_go_flutter/component/home/page/home_page_child_category.dart';
import 'package:happy_go_go_flutter/component/home/page/first/home_page_child_first.dart';
import 'package:happy_go_go_flutter/component/home/page/home_page_child_person.dart';
import 'package:happy_go_go_flutter/component/home/page/test_page.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///首页
class HomePage extends StatefulWidget {
  static const String sName = "HomePage";

  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
//      color: AppColors.white,s
      child: new TabBarWidget(
        type: TabType.bottom,
        tabItems: <Widget>[
          new Tab(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.home,
                  size: 20,
                ),
                new Text("首页")
              ],
            ),
          ),
          new Tab(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.category,
                  size: 20,
                ),
                new Text("分类")
              ],
            ),
          ),
          new Tab(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.shopping_cart,
                  size: 20,
                ),
                new Text("购物车")
              ],
            ),
          ),
          new Tab(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(
                  Icons.person,
                  size: 20,
                ),
                new Text("我的")
              ],
            ),
          )
        ],
        tabViews: <Widget>[
          new HomePageChildFirst(),
//          new HomePageChildCategory(),
          new TestPage2(),
          new HomePageChildCart(),
          new HomePageChildPerson(),
        ],
        indicatorColor: AppColors.transparent,
        backgroundColor: AppColors.primary,
        pageViewCanScroll: false,
        isShowAppBar: false,
      ),
    );
  }
}
