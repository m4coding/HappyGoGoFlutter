import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/widgets/tabs.dart' as MyTab;

///支持顶部和顶部的TabBar控件
///配合AutomaticKeepAliveClientMixin可以keep住
class TabBarWidget extends StatefulWidget {
  final TabType type;

  final bool resizeToAvoidBottomPadding;

  final List<Widget> tabItems;

  final List<Widget> tabViews;

  final Color backgroundColor;

  final Color indicatorColor;

  final Widget title;

  final Widget drawer;

  final Widget floatingActionButton;

  final FloatingActionButtonLocation floatingActionButtonLocation;

  final Widget bottomBar;

  final List<Widget> footerButtons;

  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onDoublePress;
  final bool Function(int value) onSinglePress;

  final bool pageViewCanScroll; //pageView是否响应用户手指而滑动
  final bool isShowAppBar;

  final PageController pageController;

  TabBarWidget({
    Key key,
    this.type = TabType.top,
    this.tabItems,
    this.tabViews,
    this.backgroundColor,
    this.indicatorColor,
    this.title,
    this.drawer,
    this.bottomBar,
    this.onDoublePress,
    this.onSinglePress,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.resizeToAvoidBottomPadding = true,
    this.footerButtons,
    this.onPageChanged,
    this.pageViewCanScroll = true,
    this.isShowAppBar = true,
    this.pageController,
  }) : super(key: key);

  @override
  _TabBarState createState() => new _TabBarState();
}

class _TabBarState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: widget.tabItems.length);
  }

  ///整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _navigationPageChanged(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    _tabController.animateTo(index);
    widget.onPageChanged?.call(index);
  }

  bool _navigationTapClick(index) {
    if (_index == index) {
      return true;
    }

    if (widget.onSinglePress?.call(index) == true) { //返回true表示已消费事件，不会往下处理
      return true;
    }

    _index = index;
    widget.onPageChanged?.call(index);

    ///不想要动画
    widget.pageController.jumpTo(MediaQuery.of(context).size.width * index);

    return false;
  }

  bool _navigationDoubleTapClick(index) {
    if (_navigationTapClick(index) == true) {
      widget.onDoublePress?.call(index);
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == TabType.top) {
      ///顶部tab bar
      return new Scaffold(
        drawer: widget.drawer,
        resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
        floatingActionButton:
            SafeArea(child: widget.floatingActionButton ?? Container()),
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        persistentFooterButtons: widget.footerButtons,
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          bottom: new TabBar(
              controller: _tabController,
              tabs: widget.tabItems,
              indicatorColor: widget.indicatorColor,
              onTap: _navigationTapClick),
        ),
        body: new PageView(
          controller: widget.pageController,
          children: widget.tabViews,
          onPageChanged: _navigationPageChanged,
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    }

    ///底部tab bar
    return new Scaffold(
        drawer: widget.drawer,
        appBar: widget.isShowAppBar ? new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
        ) : null,
        body: new PageView(
          controller: widget.pageController,
          children: widget.tabViews,
          onPageChanged: _navigationPageChanged,
          physics: widget.pageViewCanScroll ? new PageScrollPhysics() : new NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: new Material(
          //为了适配主题风格，包一层Material实现风格套用
          color: Theme.of(context).primaryColor, //底部导航栏主题颜色
          child: new SafeArea(
            child: new MyTab.TabBar(
              //TabBar导航标签，底部导航放到Scaffold的bottomNavigationBar中
              controller: _tabController,
              //配置控制器
              tabs: widget.tabItems,
              indicatorColor: widget.indicatorColor,
              onDoubleTap: _navigationDoubleTapClick,
              onTap: _navigationTapClick, //tab标签的下划线颜色
            ),
          ),
        ));
  }
}

enum TabType { top, bottom }
