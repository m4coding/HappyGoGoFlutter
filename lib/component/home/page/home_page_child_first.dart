import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happy_go_go_flutter/base/widgets/custom_banner.dart';
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
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    this.tabController = TabController(length: 2, vsync: this);
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
                Container(
                  color: AppColors.primary,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    //头部
                    children: <Widget>[
                      Expanded(
                          child: new Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            color: AppColors.white,
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
                            style: TextStyle(color: AppColors.white, fontSize: 12),
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
                            style: TextStyle(color: AppColors.white, fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
//                        SliverList(
//                          delegate: SliverChildListDelegate(
//                            [
//                              CustomBanner([1, 2, 3, 4, 5], 200, (index) {
//                                return "https://timgsa.baidu.com/timg"
//                                    "?image&quality=80&size=b9999_10000&sec=1583470082401&di=dd953"
//                                    "713eb661c2ade9007376a33ff16&imgtype=0&src=http%3A%2F%2Fa3.att.hud"
//                                    "ong.com%2F68%2F61%2F3000008397641270606"
//                                    "14318218_950.jpg";
//                              }, onItemClick: (index) {
//                                print("index=$index, banner child click");
//                              }),
//                            ],
//                          ),
//                        ),
                        SliverGrid(
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
                        ),
//                        SliverList(
//                          delegate: SliverChildBuilderDelegate(
//                                  (BuildContext context, int index) {
//                                return Container(
//                                  alignment: Alignment.center,
//                                  color: Colors.lightBlue[100 * (index % 9)],
//                                  child: Text('list item $index'),
//                                );
//                              }, childCount: 50),
//                        ),
//                        SliverToBoxAdapter(
//                          child: Container(
//                            height: 100.0,
//                            child: ListView.builder(
//                              scrollDirection: Axis.horizontal,
//                              itemCount: 20,
//                              itemBuilder: (context, index) {
//                                return Container(
//                                  width: 100.0,
//                                  child: Card(
//                                    child: Text('data'),
//                                  ),
//                                );
//                              },
//                            ),
//                          ),
//                        ),
//                        SliverToBoxAdapter(
//                          child: Container(
//                            child: _getFistPage(),
//                          ),
//                        ),
                      ];
                    },
                    body: Column(
                      children: <Widget>[
//                        TabBar(
//                          isScrollable: false,
//                          labelColor: Colors.black,
//                          controller: this.tabController,
//                          tabs: <Widget>[
//                            Tab(text: '1'),
//                            Tab(text: '2'),
//                          ],
//                        ),
//                        Expanded(
//                          child: _getFistPage(),
//                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }

  _getFistPage() {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                CustomBanner([1, 2, 3, 4, 5], 200, (index) {
                  return "https://timgsa.baidu.com/timg"
                      "?image&quality=80&size=b9999_10000&sec=1583470082401&di=dd953"
                      "713eb661c2ade9007376a33ff16&imgtype=0&src=http%3A%2F%2Fa3.att.hud"
                      "ong.com%2F68%2F61%2F3000008397641270606"
                      "14318218_950.jpg";
                }, onItemClick: (index) {
                  print("index=$index, banner child click");
                }),
              ],
            ),
          ),
          SliverGrid(
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index % 9)],
                    child: Text('list item $index'),
                  );
                }, childCount: 50),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100.0,
                    child: Card(
                      child: Text('data'),
                    ),
                  );
                },
              ),
            ),
          ),
        ];
      },
      body: Column(
        children: <Widget>[
          TabBar(
            isScrollable: false,
            labelColor: Colors.black,
            controller: this.tabController,
            tabs: <Widget>[
              Tab(text: '1'),
              Tab(text: '2'),
            ],
          ),
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
      ),
    );
  }

}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final Color color;

  StickyTabBarDelegate({@required this.child, this.color});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: child,
      color: color,
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
