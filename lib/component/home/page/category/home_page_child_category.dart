import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/pageload/custom_refresh_layout.dart';
import 'package:happy_go_go_flutter/base/pageload/list_page_load.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/load_state_layout.dart';
import 'package:happy_go_go_flutter/base/widgets/status_bar_compat_widget.dart';
import 'package:happy_go_go_flutter/component/home/bean/category_bean.dart';
import 'package:happy_go_go_flutter/component/home/bean/home_product_item.dart';
import 'package:happy_go_go_flutter/component/home/net/home_net_utils.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///首页子tab-分类页
class HomePageChildCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildCategoryState();
  }
}

class _HomePageChildCategoryState extends State<HomePageChildCategory>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StatusBarCompatWidget(
      child: Column(
        children: <Widget>[
          _CategoryTopBar(),
          Expanded(child: _CategoryContentWidget()),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

//顶部
class _CategoryTopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      color: AppColors.primary,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
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
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              "消息",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

//分类内容
class _CategoryContentWidget extends StatefulWidget {
  @override
  __CategoryContentWidgetState createState() => __CategoryContentWidgetState();
}

class __CategoryContentWidgetState extends State<_CategoryContentWidget>
    with ListPageLoad<ProductBean> {
  CategoryBean _categoryBean;
  LoadLayoutState _globalLayoutState = LoadLayoutState.State_Loading;
  int _currentSelect = 0;

  @override
  void initState() {
    super.initState();

    _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return LoadStateLayout(
      state: _globalLayoutState,
      successWidget: Row(
        children: <Widget>[
          _getLeftWidget(),
          Expanded(child: _getRightWidget()),
        ],
      ),
    );
  }

  //左边分类
  Widget _getLeftWidget() {
    return Container(
      color: Colors.white,
      width: 100,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 0),
        itemBuilder: (context, index) {
          CategoryChildBean childBean = _categoryBean.list[index];
          Color textColor = _currentSelect == index
              ? AppColors.accent
              : AppColors.secondary_text;
          return GestureDetector(
            onTap: () {
              _currentSelect = index;
              load();
              setState(() {
              });
              refreshController.loadComplete();
            },
            child: Container(
              color: _currentSelect == index
                  ? AppColors.fff5f5f5
                  : AppColors.transparent,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
              child: Center(
                  child: Text(
                childBean.name,
                style: TextStyle(fontSize: 14, color: textColor),
              )),
            ),
          );
        },
        itemCount: _categoryBean?.list?.length ?? 0,
      ),
    );
  }

  //右边具体分类内容
  Widget _getRightWidget() {
    return LoadStateLayout(
        backgroundColor: AppColors.fff5f5f5,
        state: getLoadStateLayoutState(),
        successWidget: CustomRefreshLayout(
          enablePullUp: true,
          enablePullDown: false,
          controller: refreshController,
          onLoading: onLoadMore,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemBuilder: (context, index) {
              ProductChildBean productChildBean = dataList[index].body.items[0];
              return GestureDetector(
                child: Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1/1,
                        child: CachedNetworkImage(
                          imageUrl: productChildBean.imageUrl ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                productChildBean.productName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.primary_text),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "¥${productChildBean.productPrice}",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Container(height: 10,);
            },
            itemCount: dataList.length,
          ),
        ));
  }

  void _getCategoryList() {
    _globalLayoutState = LoadLayoutState.State_Loading;
    HomeNetUtils.getCategoryList(1, 20, isRootCategory: false).then((value) {
      _categoryBean = value;
      if (_categoryBean.list == null || _categoryBean.list.isEmpty) {
        _globalLayoutState = LoadLayoutState.State_Empty;
      } else {
        _globalLayoutState = LoadLayoutState.State_Success;
        //加载右边商品信息
        load();
      }

      setState(() {});
    }).catchError((onError) {
      ToastUtils.show(onError.toString());
      setState(() {
        _globalLayoutState = LoadLayoutState.State_Error;
      });
    });
  }

  @override
  Future<List<ProductBean>> getData(int page, int pageSize) {
    return HomeNetUtils.getPageListInfo(
            page, pageSize, _categoryBean.list[_currentSelect].categoryId)
        .then((value) => List<ProductBean>.from(value.list));
  }

  @override
  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }
}
