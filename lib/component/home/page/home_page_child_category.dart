import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///首页子tab-分类页
class HomePageChildCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildCategoryState();
  }

}

class _HomePageChildCategoryState extends State<HomePageChildCategory> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
//    return new Container(child: Text("Category"),);
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            ListTile(
              leading: Icon(Icons.volume_off),
              title: Text("Volume Off"),
            ),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
            ListTile(
                leading: Icon(Icons.volume_down), title: Text("Volume Down")),
          ]),
        ),
        DefaultTabController(
          length: 3,
          child: NestedScrollView(
//            pinnedHeaderSliverHeightBuilder: () {
//              print(statusBarHeight + 46.0);
//              return statusBarHeight + 46.0 + 200.0;
//            },
            headerSliverBuilder: (context, boxIsScrolled) {
              return [
                SliverAppBar(
                  floating: true,

                  expandedHeight: 200.0,
                  title: Text("Demo"),
                  // FlexibleSpaceBar(
                  //   collapseMode: CollapseMode.pin,
                  //   background: Image.asset(
                  //     "img/a.jpg",
                  //     fit: BoxFit.cover,
                  //   ),
                  // )
                  flexibleSpace: Image.asset(
                    "img/a.jpg",
                    fit: BoxFit.cover,
                  ),
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        icon: Icon(
                          Icons.directions_bike,
                          color: Colors.blue,
                        ),
                      ),
                      Tab(
                        icon: Icon(Icons.directions_bike, color: Colors.blue),
                      ),
                      Tab(
                        icon: Icon(Icons.directions_bike, color: Colors.blue),
                      )
                    ],
                  ),
                ),
              ];
            },
            body: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    ListTile(
                      leading: Icon(Icons.volume_off),
                      title: Text("Volume Off"),
                    ),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_mute),
                        title: Text("Volume Mute")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                    ListTile(
                        leading: Icon(Icons.volume_down),
                        title: Text("Volume Down")),
                  ]),
                ),
                SliverFillRemaining(
                  // TabBarView
                  child: TabBarView(
                    children: <Widget>[
                      Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                              Text("swjmjj"),
                            ],
                          ),
                        ),
                      ),
                      Center(child: Text('Content of Profile')),
                      Center(child: Text('Content of Profile')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )

        // SliverPersistentHeader(
        //   // 可以吸顶的TabBar
        //   pinned: true,
        //   delegate: StickyTabBarDelegate(
        //       child: TabBar(
        //     tabs: <Widget>[
        //       Tab(
        //         icon: Icon(Icons.directions_bike,color: Colors.blue,),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.directions_bike,color: Colors.blue),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.directions_bike,color: Colors.blue),
        //       )
        //     ],
        //   )),
        // ),
        // SliverFillRemaining(
        //   // TabBarView
        //   child: TabBarView(
        //     children: <Widget>[
        //       Container(
        //         child: Center(
        //           child: Column(
        //             children: <Widget>[
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //               Text("swjmjj"),
        //             ],
        //           ),
        //         ),
        //       ),
        //       Center(child: Text('Content of Profile')),
        //       Center(child: Text('Content of Profile')),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}