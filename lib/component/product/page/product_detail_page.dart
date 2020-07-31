import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/custom_banner.dart';
import 'package:happy_go_go_flutter/component/cart/cart_page_manager.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_bean.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_param.dart';
import 'package:happy_go_go_flutter/component/product/dialog/product_detail_shopping_dialog.dart';
import 'package:happy_go_go_flutter/component/product/net/product_net_utils.dart';
import 'package:happy_go_go_flutter/component/product/wigets/product_detail_load_footer.dart';
import 'package:happy_go_go_flutter/component/product/wigets/product_detail_recommend_layout.dart';
import 'package:happy_go_go_flutter/component/product/wigets/product_detail_top_bar.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///商品详情页
class ProductDetailPage extends StatefulWidget {
  final ProductDetailParam productDetailParam;

  static newInstance(
      BuildContext context, ProductDetailParam productDetailParam) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return ProductDetailPage(productDetailParam);
      },
    ));
  }

  ProductDetailPage(this.productDetailParam);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailPageState();
  }
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductDetailParam _productDetailParam;
  ProductDetailBean _productDetailBean;

  GlobalKey _productPicKey = GlobalKey();
  GlobalKey _productBaseInfoKey = GlobalKey();
  GlobalKey<ProductDetailRecommendLayoutState> _productRecommendKey =
      GlobalKey();
  GlobalKey<ProductDetailLoadFooterState> _loadStatusKey = GlobalKey();
  GlobalKey<ProductDetailTopBarState> _productTopKey = GlobalKey();
  ScrollController _scrollController;

  double _topBarHeight;
  bool _isTopSelectToScroll = false;

  @override
  void initState() {
    super.initState();

    _productDetailParam = widget.productDetailParam;
    _scrollController = ScrollController();
    _getNetData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _topBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController?.dispose();
    _scrollController = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.fff5f5f5,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: NotificationListener(
                onNotification: (ScrollNotification notification) {
                  double progress = notification.metrics.pixels /
                      notification.metrics.maxScrollExtent;
                  if (_productRecommendKey.currentState != null) {
                    _productRecommendKey.currentState
                        .onScrollProgress(progress);
                  }

                  if (_productTopKey.currentState != null) {
                    _productTopKey.currentState.onScrollProgress(notification);

                    //滚动时设置顶部栏的选中类型
                    if (!_isTopSelectToScroll) { //标志位判断，避免jumpTo时的异常
                      if (_getPaintHeightByKey(_productPicKey) +
                          _getPaintHeightByKey(_productBaseInfoKey) -
                          _topBarHeight >
                          0) {
                        _productTopKey.currentState
                            .selectTopType(ProductTopType.PRODUCT);
                      } else {
                        _productTopKey.currentState
                            .selectTopType(ProductTopType.RECOMMEND);
                      }
                    }
                  }
//                  logger.d("CustomScrollView progress=$progress");
                  return false;
                },
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: <Widget>[
                    _getProductPicView(),
                    _getProductBaseInfoView(),
                    _getRecommendTitle(),
                    _getRecommendList(),
                    _getFooterLoadStatusWidget(),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 120),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: _getTopBar(),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _getBottomOperationLayout()),
          ],
        ),
      ),
    );
  }

  double _getPaintHeightByKey(GlobalKey globalKey) {
    var size = globalKey?.currentContext
        ?.findRenderObject()
        ?.paintBounds //paintBounds表示在屏幕内可见时的绘制边框
        ?.size;
    return size?.height ?? 0;
  }

  ///获取sliver的实际高度
  double _getScrollExtentByKey(GlobalKey globalKey) {
    RenderSliver renderSliver = globalKey.currentContext.findRenderObject() as RenderSliver;
    return renderSliver?.geometry?.scrollExtent ?? 0;
  }

  void _getNetData() {
    ProductNetUtils.getProductDetail(_productDetailParam.productSkuId)
        .then((value) {
      setState(() {
        _productDetailBean = value;
      });
    }).catchError((onError) {
      ToastUtils.show(onError.toString());
    });
  }

  Widget _getTopBar() {
    return ProductDetailTopBar(
      key: _productTopKey,
      barHeight: _topBarHeight,
      onSelectTopType: (productTopType) {
        switch (productTopType) {
          case ProductTopType.PRODUCT:
            _scrollController.jumpTo(0.0);
            break;
          case ProductTopType.RECOMMEND:
            double scrollOffset = _getScrollExtentByKey(_productPicKey)
                + _getScrollExtentByKey(_productBaseInfoKey) - _topBarHeight;
            _isTopSelectToScroll = true;
            _scrollController.jumpTo(scrollOffset);
            //延时一段时间去阻断滚动监听器的设置
            Future.delayed(Duration(milliseconds: 100)).then((value) => _isTopSelectToScroll = false);
            break;
        }
      },
    );
  }

  Widget _getProductPicView() {
    int currentIndex = 1;

    List<String> items = _productDetailBean?.imageUrls != null
        ? _productDetailBean?.imageUrls
        : List();
    double height = 400;
    if (items.isNotEmpty) {
      return SliverToBoxAdapter(
        key: _productPicKey,
        child: CustomBanner(items, height, (int index) {
          return items[index];
        }, onPageChanged: (int index) {
          currentIndex = index + 1;
        },
            autoPlay: false,
            enableInfiniteScroll: false,
            indicatorWidget: Positioned(
              right: 10,
              bottom: 20,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Text(
                  "$currentIndex/${items.length}",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            )),
      );
    } else {
      return SliverToBoxAdapter(
          key: _productPicKey,
          child: Container(
            height: height,
          ));
    }
  }

  Widget _getProductBaseInfoView() {
    return SliverToBoxAdapter(
        key: _productBaseInfoKey,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                    text: "¥",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: _productDetailBean?.productPrice ?? "",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                _productDetailBean?.productName ?? "",
                style: TextStyle(
                    color: AppColors.primary_text,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              _getBrand(),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                "库存：${_productDetailBean?.stock}",
                style: TextStyle(color: AppColors.secondary_text, fontSize: 13),
              ),
            ],
          ),
        ));
  }

  Widget _getBrand() {
    return _productDetailBean?.brand != null ||
            _productDetailBean?.brand?.isNotEmpty == true
        ? Container(
            padding: EdgeInsets.only(top: 10),
            child: (Text(
              "品牌：${_productDetailBean?.brand}",
              style: TextStyle(color: AppColors.secondary_text, fontSize: 13),
            )),
          )
        : Container();
  }

  //为你推荐标题
  Widget _getRecommendTitle() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10),
      sliver: SliverToBoxAdapter(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 7),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
          child: Text(
            S.of(context).recommend_for_you,
            style: TextStyle(
                color: AppColors.primary_text,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _getRecommendList() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      sliver: ProductDetailRecommendLayout(
        key: _productRecommendKey,
        onLoadTypeChange: (loadType) {
          if (_loadStatusKey.currentState != null) {
            _loadStatusKey.currentState.updateStatus(loadType);
          }
        },
      ),
    );
  }

  Widget _getFooterLoadStatusWidget() {
    return ProductDetailLoadFooter(
      key: _loadStatusKey,
      onFailRetry: () {
        _productRecommendKey.currentState.loadMore();
      },
    );
  }

  //底部操作layout
  Widget _getBottomOperationLayout() {
    return Column(
      children: <Widget>[
        Container(
          height: 0.5,
          color: AppColors.divider,
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(
                    Icons.contacts,
                    color: AppColors.primary_text,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                  ),
                  Text(
                    S.of(context).contact,
                    style:
                        TextStyle(color: AppColors.primary_text, fontSize: 13),
                  )
                ],
              ),
              GestureDetector(
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.shopping_cart,
                      color: AppColors.primary_text,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2),
                    ),
                    Text(
                      S.of(context).cart,
                      style:
                          TextStyle(color: AppColors.primary_text, fontSize: 13),
                    )
                  ],
                ),
                onTap: () {
                  CartPageManager.goToCartPage(context);
                },
              ),
              RaisedButton(
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  child: Center(
                      child: Text(
                    S.of(context).add_to_cart,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.red,
                onPressed: () {
                  ProductDetailShoppingDialog.show(_productDetailBean);
                },
              ),
              RaisedButton(
                elevation: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                  child: Center(
                      child: Text(
                    S.of(context).go_to_bug,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.orange,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
