import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happy_go_go_flutter/base/widgets/custom_banner.dart';
import 'package:happy_go_go_flutter/base/widgets/sliver/sliver_header_delegate.dart';
import 'package:happy_go_go_flutter/base/widgets/status_bar_compat_widget.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///首页子tab-首页tab
class HomePageChildFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildFirstState();
  }
}

class _HomePageChildFirstState extends State<HomePageChildFirst>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController tabController;
  TabController _headerTabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    this.tabController = TabController(length: 2, vsync: this);
    this._headerTabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        // 监听滑动/点选位置
        if (_headerTabController.index.toDouble() ==
            _headerTabController.animation.value) {
          setState(() => _currentIndex = _headerTabController.index);
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
    _headerTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getBuild();
  }

  @override
  bool get wantKeepAlive => true;

  _getBuild() {
    return new StatusBarCompatWidget(
        child: new Container(
            child: Column(
      children: <Widget>[
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverCustomHeaderDelegate(
                    collapsedHeight: 60,
                    expandedHeight: 110,
                    paddingTop: /*MediaQuery.of(context).padding.top*/ 0,
                  ),
                ),
                SliverToBoxAdapter(
                  child: TabBar(
                    isScrollable: false,
                    labelColor: Colors.black,
                    controller: this._headerTabController,
                    tabs: <Widget>[
                      Tab(text: '头部1'),
                      Tab(text: '头部2'),
                    ],
                  ),
                ),
                _getHeader(),
                _getStickyTab(),
              ];
            },
            body: _getBody(),
          ),
        ),
      ],
    )));
  }

  Widget _getHeader() {
    if (_currentIndex == 0) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('grid item $index'),
            );
          },
          childCount: 10,
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Center(
          child: Text("hahah"),
        ),
      );
    }
  }

  Widget _getStickyTab() {
    if (_currentIndex == 0) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: SliverStickyTabBarDelegate(
          color: AppColors.white,
          child: TabBar(
            isScrollable: false,
            labelColor: Colors.black,
            controller: this.tabController,
            tabs: <Widget>[
              Tab(text: '底部1'),
              Tab(text: '底部2'),
            ],
          ),
        ),
      );
    }
  }

  Widget _getBody() {
    if (_currentIndex == 0) {
      return Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
//                      Center(child: Text('Content of 1')),
                StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: 300,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.network("https://timgsa.baidu.com/timg"
                        "?image&quality=80&size=b9999_10000&sec=1583470082401&di=dd953"
                        "713eb661c2ade9007376a33ff16&imgtype=0&src=http%3A%2F%2Fa3.att.hud"
                        "ong.com%2F68%2F61%2F3000008397641270606"
                        "14318218_950.jpg");
                  },
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.count(2, index == 0 ? 1.5 : 2),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                ListView.builder(
                  itemCount: 200,
                  itemExtent: 50,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('Title $index'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return ListView.builder(
        itemCount: 200,
        itemExtent: 50,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text('Title $index'),
          );
        },
      );
    }
  }
}

class SliverCustomHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double collapsedHeight;
  final double expandedHeight;
  final double paddingTop;
  double barMinWidth;
  double barMaxWidth;
  double padding = 10;


  SliverCustomHeaderDelegate({
    this.collapsedHeight,
    this.expandedHeight,
    this.paddingTop,
  }) {
    barMinWidth = 310;
  }

  @override
  double get minExtent => this.collapsedHeight + this.paddingTop;

  @override
  double get maxExtent => this.expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  double makeSearchBarWidth(double shrinkOffset) { //收起来后shrinkOffset最大，展开后shrinkOffset最小
    double temp = shrinkOffset / (this.maxExtent);
    temp = temp * 6; //使增值加大
    double returnValue = barMinWidth + (barMaxWidth - barMinWidth) * (1 - temp);
    if (returnValue < barMinWidth) { //限定范围
      returnValue = barMinWidth;
    }
//    print("makeSearchBarWidth barMinWidth=$barMinWidth, barMaxWidth=$barMaxWidth, shrinkOffset=$shrinkOffset, temp=$temp, returnValue=$returnValue");
    return (barMaxWidth - returnValue);
  }

  int makeTitleColor(double shrinkOffset) { //收起来后shrinkOffset最大，展开后shrinkOffset最小
    double temp = shrinkOffset / (this.maxExtent);
    temp = temp * 3; //使增值加大
    int returnValue = (255 * (1 - temp)).toInt();
    if (returnValue < 0) { //限定范围
      returnValue = 0;
    }
//    print("makeTitleColor returnValue=$returnValue");
    return returnValue;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    barMaxWidth = MediaQuery.of(context).size.width - padding * 2;

    return Container(
      height: this.maxExtent,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // 背景图
          Container(color: AppColors.primary),
          // 收起头部
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              child: Container(
//                  color: AppColors.primary,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child:  Row(
                  //头部
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  new Container(
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    height: 35,
                                    child: Row(children: <Widget>[
                                      Text("HappyGo", style: TextStyle(fontSize: 20, color: Color.fromARGB(makeTitleColor(shrinkOffset), 255, 255, 255)),),
                                    ],),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.scanner,
                          color: AppColors.white,
                          size: 20,
                        ),
                        Text(
                          "扫啊扫",
                          style: TextStyle(
                              color: AppColors.white, fontSize: 12),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    ),
                    Column(
                      children: <Widget>[
                        Icon(
                          Icons.message,
                          color: AppColors.white,
                          size: 20,
                        ),
                        Text(
                          "消息",
                          style: TextStyle(
                              color: AppColors.white, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: makeSearchBarWidth(shrinkOffset),
            child: Padding(
              padding: EdgeInsets.fromLTRB(padding, 0, padding, padding),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: AppColors.secondary_text,
                      size: 20,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                    Text(
                      "商品名",
                      style: TextStyle(
                          color: AppColors.secondary_text, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
