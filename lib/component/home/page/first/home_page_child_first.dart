import 'dart:collection';

import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as ens;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/base/net/net_result_data.dart';
import 'package:happy_go_go_flutter/base/widgets/custom_banner.dart';
import 'package:happy_go_go_flutter/base/widgets/nested_scroll_view_refresh_layout.dart';
import 'package:happy_go_go_flutter/base/widgets/sliver/sliver_header_delegate.dart';
import 'package:happy_go_go_flutter/base/widgets/status_bar_compat_widget.dart';
import 'package:happy_go_go_flutter/component/home/bean/home_item.dart';
import 'package:happy_go_go_flutter/component/home/page/first/home_page_child_first_page_view.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';
import 'package:loading_more_list/loading_more_list.dart';

///首页子tab-首页tab
class HomePageChildFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildFirstState();
  }
}

class _HomePageChildFirstState extends State<HomePageChildFirst>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController _bottomTabController;
  TabController _headerTabController;
  int _currentIndex = 0;
  HomeTopContentBean _homeTopContentBean = new HomeTopContentBean();
  BodyTabChannelBean _bodyTabChannelBean;

  @override
  void initState() {
    super.initState();
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
    if (_bottomTabController != null) {
      _bottomTabController.dispose();
      _bottomTabController = null;
    }

    if (_headerTabController != null) {
      _headerTabController.dispose();
      _headerTabController = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getBuild();
  }

  @override
  bool get wantKeepAlive => true;

  _getNetData() async {
    HashMap<String, String> requestParams = new HashMap();
    await HttpManager().post(HttpAddress.urlGetPageContentInfo, requestParams,
        (Map<String, dynamic> json) {
          HomeTopContentBean homeTopContentBean =  HomeTopContentBean.fromJson(json);
          //动态转换一下，因为JsonSerializable不能动态转换dynamic类型的字段
          if (homeTopContentBean.sections != null && homeTopContentBean.sections.isNotEmpty) {
            for (SectionBean sectionBean in homeTopContentBean.sections) {
                switch(sectionBean.viewType) {
                  case HomeTopContentBean.VIEW_TYPE_GALLERY:
                    sectionBean.body = BodyGalleryBean.fromJson(sectionBean.body);
                    break;
                  case HomeTopContentBean.VIEW_TYPE_TAB_CHANNEL:
                    sectionBean.body = BodyTabChannelBean.fromJson(sectionBean.body);
                    _bodyTabChannelBean = sectionBean.body;
                    if (_bodyTabChannelBean != null && _bodyTabChannelBean.items != null) {
                      _initBottomTab(_bodyTabChannelBean.items.length);
                    }
                    break;
                }
            }
          }
          return homeTopContentBean;
    }).then((NetResultProcessData res) {
      if (res.isSuccess) {
        setState(() {
          _homeTopContentBean = res.data;
        });
      } else {
        Fluttertoast.showToast(msg: res.message);
      }
    });
  }

  _getBuild() {
    return new StatusBarCompatWidget(
        child: new Container(
            child: Column(
      children: <Widget>[
        Expanded(
          child: NestedScrollViewRefreshLayout(
            onRefresh: () {
              return _getNetData();
            },
            child: ens.NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return _getHeaderList();
              },
              body: _getBody(),
            ),
          ),
        ),
      ],
    )));
  }

  List<Widget> _getHeaderList() {
    List<Widget> list = [];
    if (_currentIndex == 0) {
      list.add(_getTopBar(60, 110));
      list.add(_getTopTab(false));
      if (_homeTopContentBean.sections != null) {
        for (SectionBean sectionBean in _homeTopContentBean.sections) {
          switch (sectionBean.viewType) {
            case HomeTopContentBean.VIEW_TYPE_GALLERY:
              if (sectionBean.body is BodyGalleryBean) {
                BodyGalleryBean bodyGalleryBean = sectionBean.body;
                if (bodyGalleryBean.items != null &&
                    bodyGalleryBean.items.isNotEmpty) {
                  list.add(_getBanner(bodyGalleryBean.items));
                }
              }
              break;
            case HomeTopContentBean.VIEW_TYPE_TAB_CHANNEL:
              if (sectionBean.body is BodyTabChannelBean) {
                BodyTabChannelBean bodyTabChannelBean = sectionBean.body;
                if (bodyTabChannelBean.items != null &&
                    bodyTabChannelBean.items.isNotEmpty) {
                  list.add(_getTabChannel(bodyTabChannelBean.items));
                }
              }
              break;
          }
        }
      }
    } else {
      list.add(_getTopBar(110, 110));
      list.add(_getTopTab(true));
      list.add(_getGridView());
    }

    return list;
  }

  _initBottomTab(int length) {
    _bottomTabController = TabController(length: length, vsync: this);
  }

  ///collapsedHeight 缩起的高度
  ///expandedHeight 展开的高度
  Widget _getTopBar(double collapsedHeight, double expandedHeight) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverCustomHeaderDelegate(
        collapsedHeight: collapsedHeight,
        expandedHeight: expandedHeight,
        paddingTop: /*MediaQuery.of(context).padding.top*/ 0,
      ),
    );
  }

  Widget _getTopTab(bool pinned) {
    if (pinned) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: SliverStickyTabBarDelegate(
          color: AppColors.white,
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
      );
    } else {
      return SliverToBoxAdapter(
        child: TabBar(
          isScrollable: false,
          labelColor: Colors.black,
          controller: this._headerTabController,
          tabs: <Widget>[
            Tab(text: '头部1'),
            Tab(text: '头部2'),
          ],
        ),
      );
    }
  }

  Widget _getBanner(List<GalleryChildBean> items) {
    return SliverToBoxAdapter(child: CustomBanner(items, 200, (int index) {return items[index].imageUrl;},
        onItemClick: (int index) {

        }));
  }

  Widget _getTabChannel(List<TabChannelChildBean> items) {
    List<Widget> list = [];
    for (TabChannelChildBean channelChildBean in items) {
      list.add(Tab(text: channelChildBean.title));
    }

    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverStickyTabBarDelegate(
        color: AppColors.white,
        child: TabBar(
          isScrollable: false,
          labelColor: Colors.black,
          controller: this._bottomTabController,
          tabs: list,
        ),
      ),
    );
  }

  Widget _getGridView() {
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
  }

  Widget _getBody() {
    if (_currentIndex == 0) {
      if (_bottomTabController == null || _bottomTabController.length == 0) {
        return Column(
          children: <Widget>[
//            Expanded(
//
//            ),
          ],
        );
      }
      List<Widget> list = [];
      for (TabChannelChildBean tabChannelChildBean in _bodyTabChannelBean.items) {
          list.add(HomePageChildFirstStaggeredGridView(tabChannelChildBean.type));
      }

      return Column(
        children: <Widget>[
          Expanded(
            child: TabBarView(
              controller: _bottomTabController,
              children: list,
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

  double makeSearchBarWidth(double shrinkOffset) {
    //收起来后shrinkOffset最大，展开后shrinkOffset最小
    if (this.minExtent >= this.maxExtent) {
      //不改变
      return 0;
    }

    double temp = shrinkOffset / (this.maxExtent);
    temp = temp * 6; //使增值加大
    double returnValue = barMinWidth + (barMaxWidth - barMinWidth) * (1 - temp);
    if (returnValue < barMinWidth) {
      //限定范围
      returnValue = barMinWidth;
    }
//    print("makeSearchBarWidth barMinWidth=$barMinWidth, barMaxWidth=$barMaxWidth, shrinkOffset=$shrinkOffset, temp=$temp, returnValue=$returnValue");
    return (barMaxWidth - returnValue);
  }

  int makeTitleColor(double shrinkOffset) {
    //收起来后shrinkOffset最大，展开后shrinkOffset最小

    if (this.minExtent >= this.maxExtent) {
      //不改变
      return 255;
    }

    double temp = shrinkOffset / (this.maxExtent);
    temp = temp * 3; //使增值加大
    int returnValue = (255 * (1 - temp)).toInt();
    if (returnValue < 0) {
      //限定范围
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
                child: Row(
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
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "HappyGo",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              makeTitleColor(shrinkOffset),
                                              255,
                                              255,
                                              255)),
                                    ),
                                  ],
                                ),
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
                          style:
                              TextStyle(color: AppColors.white, fontSize: 12),
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
                          style:
                              TextStyle(color: AppColors.white, fontSize: 12),
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
