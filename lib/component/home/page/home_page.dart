import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/widgets/tabbar_widget.dart';
import 'package:happy_go_go_flutter/component/auth/auth_page_manager.dart';
import 'package:happy_go_go_flutter/component/auth/manager/login_manager.dart';
import 'package:happy_go_go_flutter/component/cart/page/home_page_child_cart.dart';
import 'package:happy_go_go_flutter/component/home/page/category/home_page_child_category.dart';
import 'package:happy_go_go_flutter/component/home/page/first/home_page_child_first.dart';
import 'package:happy_go_go_flutter/component/person/page/home_page_child_person.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
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

  GlobalKey<HomePageChildCartState> _cartKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Container(
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
                new Text(S.of(context).home_page)
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
                new Text(S.of(context).category)
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
                new Text(S.of(context).shopping_cart)
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
                new Text(S.of(context).mine)
              ],
            ),
          )
        ],
        tabViews: <Widget>[
          new HomePageChildFirst(),
          new HomePageChildCategory(),
          new HomePageChildCart(key: _cartKey),
          new HomePageChildPerson(),
        ],
        indicatorColor: AppColors.transparent,
        backgroundColor: AppColors.primary,
        pageViewCanScroll: false,
        isShowAppBar: false,
        pageController: new PageController(),
        onPageChanged: (index) {
          if (index == 2) {
            Future.delayed(Duration(milliseconds: 100), () { //延时一段时间，为了currentState已初始化成功
              _cartKey.currentState?.isVisibleInTab = true;
            });
            _cartKey.currentState?.load();
          } else {
            _cartKey.currentState?.isEditMode = false;
            _cartKey.currentState?.isVisibleInTab = false;
            _cartKey.currentState?.updateCartInfo();
          }
        },
        onSinglePress: (index) {
          if (index == 2 || index == 3) { //购物车tab、我的tab需要登录状态下才能进入
            if (!LoginManager.getInstance().isLogin()) {
                AuthPageManager.goToLoginPage();
                return true;
            }
          }

          return false;
        },
      ),
    );
  }
}
