import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/base/pageload/list_page_load.dart';
import 'package:happy_go_go_flutter/base/widgets/load_state_layout.dart';
import 'package:happy_go_go_flutter/component/home/bean/home_product_item.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_param.dart';
import 'package:happy_go_go_flutter/component/product/product_manager.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///首页tab中的page子View

class HomePageChildFirstStaggeredGridView extends StatefulWidget {
  final String type;

  HomePageChildFirstStaggeredGridView(this.type);

  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildFirstStaggeredGridViewState();
  }
}

class _HomePageChildFirstStaggeredGridViewState
    extends State<HomePageChildFirstStaggeredGridView>
    with ListPageLoad<ProductBean>, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    refreshController.footerMode.addListener(() {
      setState(() {});
    });

    load();
  }

  @override
  void dispose() {
    super.dispose();
    refreshController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //列数 = crossAxisCount / StaggeredTile指定的占据几个单元格
    return LoadStateLayout(
      state: getLoadStateLayoutState(),
      errorRetry: load,
      successWidget: NotificationListener(
        onNotification: (ScrollNotification notification) {
          double progress = notification.metrics.pixels /
              notification.metrics.maxScrollExtent;
          //快到底部、不在加载状态、不在加载更多错误状态才去加载数据
          if (progress > 0.95 &&
              !refreshController.isLoading &&
              refreshController.footerMode.value != LoadStatus.failed &&
              refreshController.footerMode.value != LoadStatus.noMore) {
//            print("onLoadMore");
            refreshController.footerMode?.value = LoadStatus.loading;
            onLoadMore();
          }
          return false; //false表示不消费滚动事件，继续往上层传动
        },
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
        color: AppColors.fff5f5f5,
        child: CustomScrollView(slivers: <Widget>[
          SliverStaggeredGrid.countBuilder(
            crossAxisCount: 2,
            //纵轴方向被划分的个数
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              ProductChildBean productChildBean =
                  dataList[index].body.items[0];
              return GestureDetector(
                onTap: () {
                  ProductDetailParam param = new ProductDetailParam()
                    ..productSkuId = productChildBean.productSkuId;
                  ProductManager.goToProductDetail(context, param);
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.all(Radius.circular(15))),
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 200,
                            child: ConstrainedBox(
                              constraints: new BoxConstraints.expand(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.zero,
                                    bottomRight: Radius.zero),
                                child: CachedNetworkImage(
                                  imageUrl: productChildBean.imageUrl ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Text(
                            productChildBean.productName,
                            maxLines: 2, //最大行数
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Text(
                            "¥${productChildBean.productPrice}",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    )),
              );
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            mainAxisSpacing: 10,
            //主轴item之间的距离（px）
            crossAxisSpacing: 10, //纵轴item之间的距离（px）
          ),
          SliverToBoxAdapter(child: _getLoadMoreWidget(),),
        ],),
      ),
      ),
    );
  }

  //加载更多样式
  Widget _getLoadMoreWidget() {
    Widget body;
    LoadStatus mode = refreshController.footerMode.value;
    if (mode == LoadStatus.idle || mode == LoadStatus.canLoading) {
      return Container();
    } else if (mode == LoadStatus.loading) {
      body = CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = GestureDetector(
          onTap: () {
            onLoadMore(); //错误时，点击会再去加载数据
          },
          child: Text("加载失败，点击重试"));
    } else {
      body = Text("没有更多数据了");
    }

    return Container(
      height: 55.0,
      child: Center(child: body),
    );
  }

  @override
  Future<List<ProductBean>> getData(int page, int pageSize) {
    HashMap<String, dynamic> requestParams = new HashMap();
    requestParams["pageSize"] = pageSize;
    requestParams["pageNum"] = page;
    requestParams["tabType"] = widget.type;
    return HttpManager().post(HttpAddress.urlGetPageListInfo, requestParams,
        (json) {
      return ProductPageBean.fromJson(json);
    }).then((value) {
      if (value.isSuccess) {
        return List<ProductBean>.from(value.data.list);
      } else {
        throw Exception(value.message);
      }
    });
  }

  @override
  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool get wantKeepAlive => true;
}
