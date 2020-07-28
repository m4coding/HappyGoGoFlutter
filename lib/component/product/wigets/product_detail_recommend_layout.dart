import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/base/pageload/list_page_load.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/component/home/bean/home_product_item.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_param.dart';
import 'package:happy_go_go_flutter/component/product/product_manager.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///商品详情--为你推荐
class ProductDetailRecommendLayout extends StatefulWidget {

  final void Function(LoadType) onLoadTypeChange;


  ProductDetailRecommendLayout({Key key, @required this.onLoadTypeChange}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailRecommendLayoutState();
  }
}

class ProductDetailRecommendLayoutState
    extends State<ProductDetailRecommendLayout> {
  int _page = 1;
  int _pageSize = 20;
  bool _isLoadMoreEnd = false;
  List<ProductBean> _dataList = List();
  LoadType _loadType;

  @override
  void initState() {
    super.initState();

    refreshLoad();
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 7.0,
          crossAxisSpacing: 7.0,
          childAspectRatio: 0.70,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {

            ProductChildBean productChildBean = _dataList[index].body.items[0];

            return GestureDetector(
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: 180,
                          child: ConstrainedBox(
                            constraints: new BoxConstraints.expand(),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                  bottomLeft: Radius.zero,
                                  bottomRight: Radius.zero),
                              child: CachedNetworkImage(
                                imageUrl: productChildBean.imageUrl ?? "",
                                fit: BoxFit.contain,
                              ),
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                        child: Text(
                          productChildBean.productName,
                          maxLines: 2, //最大行数
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: AppColors.primary_text),
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
              onTap: () {
                ProductDetailParam param = new ProductDetailParam()
                  ..productSkuId = productChildBean.productSkuId;
                ProductManager.goToProductDetail(context, param);
              },
            );
          },
          childCount: _getItemCount(),
        ));
  }

  int _getItemCount() {
    int itemCount = _dataList.length;
    return itemCount;
  }


  void onScrollProgress(double progress) {
    if (progress > 0.95) {
      if (_loadType == LoadType.LOAD_TYPE_ERROR_LOAD || _loadType == LoadType.LOAD_TYPE_ERROR_MORE_LOAD) {
        return;
      }

      loadMore();
    }
  }

  void refreshLoad() async {
    _loadType = LoadType.LOAD_TYPE_START_LOAD;
    _isLoadMoreEnd = false;
    _page = 1;

    _notifyLoadType();

    getData(_page, _pageSize).then((value) {
      _dataList.clear();
      _dataList.addAll(value);
      _loadType = LoadType.LOAD_TYPE_SUCCESS_LOAD;
      setState(() {});
      _notifyLoadType();
    }).catchError((onError) {
      logger.d(onError.toString());
      //开始加载异常
      _loadType = LoadType.LOAD_TYPE_ERROR_LOAD;
      setState(() {
      });
      _notifyLoadType();
    });
  }

  void loadMore() async {
    //加载中、加载已没有数据，都会return
    if (_isLoadMoreEnd || _loadType == LoadType.LOAD_TYPE_START_LOAD || _loadType == LoadType.LOAD_TYPE_START_MORE_LOAD) {
      return;
    }

    _loadType = LoadType.LOAD_TYPE_START_MORE_LOAD;
    _notifyLoadType();

    _page++;
    getData(_page, _pageSize).then((value) {
      if (value == null || value.isEmpty) {
        //已加载到没有数据
        _isLoadMoreEnd = true;
        _loadType = LoadType.LOAD_TYPE_MORE_LOAD_END;
        setState(() {});
      } else {
        _loadType = LoadType.LOAD_TYPE_SUCCESS_MORE_LOAD;
        _dataList.addAll(value);
        setState(() {});
      }
      _notifyLoadType();
    }).catchError((onError) {
      logger.d(onError.toString());
      //加载更多异常
      _loadType = LoadType.LOAD_TYPE_ERROR_MORE_LOAD;
      setState(() {
      });
      _notifyLoadType();
    });
  }

  Future<List<ProductBean>> getData(int page, int pageSize) {
    HashMap<String, dynamic> requestParams = new HashMap();
    requestParams["pageSize"] = pageSize;
    requestParams["pageNum"] = page;
    requestParams["tabType"] = -2000;
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

  void _notifyLoadType() {
    if (widget.onLoadTypeChange != null) {
      widget.onLoadTypeChange(_loadType);
    }
  }
}
