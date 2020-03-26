import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:happy_go_go_flutter/base/net/api.dart';
import 'package:happy_go_go_flutter/base/net/http_address.dart';
import 'package:happy_go_go_flutter/component/home/bean/home_product_item.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

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
    extends State<HomePageChildFirstStaggeredGridView> {

  ProductPageBean _productPageBean;
  int _pageSize = 10;
  int _pageNum = 1;

  @override
  void initState() {
    super.initState();
    _getNetData();
  }

  _getNetData() {
    HashMap<String, dynamic> requestParams = new HashMap();
    requestParams["pageSize"] = _pageSize;
    requestParams["pageNum"] = _pageNum;
    requestParams["tabType"] = widget.type;
    HttpManager().post(HttpAddress.urlGetPageListInfo, requestParams, (json) {
      return ProductPageBean.fromJson(json);
    }).then((res) {
      if (res.isSuccess) {
        setState(() {
          _productPageBean = res.data;
        });
      } else {
        Fluttertoast.showToast(msg: res.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //列数 = crossAxisCount / StaggeredTile指定的占据几个单元格
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      color: AppColors.fff5f5f5,
      child: StaggeredGridView.countBuilder(
        physics: ClampingScrollPhysics(),
        crossAxisCount: 2,
        //纵轴方向被划分的个数
        itemCount: _productPageBean == null || _productPageBean.list == null
            ? 0
            : _productPageBean.list.length,
        itemBuilder: (BuildContext context, int index) {
          ProductChildBean productChildBean =
          _productPageBean.list[index].body.items[0];
          return Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
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
                          child: FadeInImage.assetNetwork(
                            placeholder: productChildBean.imageUrl,
                            image: productChildBean.imageUrl,
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
              ));
        },
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        mainAxisSpacing: 10,
        //主轴item之间的距离（px）
        crossAxisSpacing: 10, //纵轴item之间的距离（px）
      ),
    );
  }
}
