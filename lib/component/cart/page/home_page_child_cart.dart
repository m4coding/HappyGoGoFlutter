import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:happy_go_go_flutter/base/app_navigator_observer.dart';
import 'package:happy_go_go_flutter/base/pageload/custom_refresh_layout.dart';
import 'package:happy_go_go_flutter/base/pageload/list_page_load.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/bar/common_bar.dart';
import 'package:happy_go_go_flutter/base/widgets/dialog/common_dialog_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/dialog/h_dialog.dart';
import 'package:happy_go_go_flutter/base/widgets/load_state_layout.dart';
import 'package:happy_go_go_flutter/component/cart/bean/cart_info_bean.dart';
import 'package:happy_go_go_flutter/component/cart/bean/cart_page_params.dart';
import 'package:happy_go_go_flutter/component/cart/data/cart_data_manager.dart';
import 'package:happy_go_go_flutter/component/cart/net/cart_net_utils.dart';
import 'package:happy_go_go_flutter/component/cart/widgets/add_cart_count_view.dart';
import 'package:happy_go_go_flutter/component/order/bean/confirm_order_params.dart';
import 'package:happy_go_go_flutter/component/order/order_page_manager.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_param.dart';
import 'package:happy_go_go_flutter/component/product/product_manager.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///首页子tab-购物车页
class HomePageChildCart extends StatefulWidget {

  final CartPageParams cartPageParams;

  static newInstance(
      BuildContext context, CartPageParams cartPageParams) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return HomePageChildCart(cartPageParams: cartPageParams);
      },
    ));
  }

  HomePageChildCart({Key key, this.cartPageParams}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageChildCartState();
  }
}

class HomePageChildCartState extends State<HomePageChildCart>
    with
        AutomaticKeepAliveClientMixin,
        ListPageLoad<CartProductInfoBean>,
        WidgetsBindingObserver,
        RouteAware {
  bool _isKeyboardShow = false;
  bool isVisibleInTab = false;
  bool isEditMode = false; //是否是编辑模式
  double _preOffset = 0;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (widget.cartPageParams != null) {
      if (widget.cartPageParams.isSinglePage) {
        isVisibleInTab = true;
      }
    }

    WidgetsBinding.instance.addObserver(this);
    load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    AppNavigatorObserver.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
    AppNavigatorObserver.routeObserver.unsubscribe(this);
    _scrollController?.dispose();
    _scrollController = null;
  }

  @override
  void didPushNext() {
    super.didPushNext();

    //路由：跳到其他页面
    if (isVisibleInTab) {
      updateCartInfo();
    }

    isEditMode = false;
  }

  @override
  void didPopNext() {
    super.didPopNext();

    //路由：从其他页面回来本页面
    if (isVisibleInTab) {
      load();
    }
  }

  @override
  void load() {
    super.load();

    setState(() {});
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(HDialog.getContext()).viewInsets.bottom > 0) {
        _isKeyboardShow = true;
      } else {
        _isKeyboardShow = false;
      }
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.paused:
        if (isVisibleInTab) {
          updateCartInfo();
        }
        isEditMode = false;
        break;
      case AppLifecycleState.resumed:
        if (isVisibleInTab) {
          load();
          setState(() {});
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_scrollController != null) {
      _scrollController.dispose();
    }

    _scrollController = ScrollController(initialScrollOffset: _preOffset);
    _scrollController.addListener(() {
      _preOffset = _scrollController.offset;
    });

    return Scaffold(
      appBar: CommonBar(
        title: S.of(context).shopping_cart,
        leadingW: Container(),
        rightDMActions: <Widget>[
          GestureDetector(
            child: Offstage(
              offstage: CartDataManager.getInstance().cartInfoBean?.productList?.isEmpty == true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                    child: Text(isEditMode ? "完成" : "编辑",
                        style: TextStyle(
                            color: AppColors.primary_text, fontSize: 16))),
              ),
            ),
            onTap: () {
              setState(() {
                isEditMode = !isEditMode;

                if (!isEditMode) {
                  //退出编辑模式时，先重置bean的编辑状态下的可选状态
                  for (CartProductInfoBean infoBean
                      in CartDataManager.getInstance()
                          .cartInfoBean
                          .productList) {
                    infoBean.isEditSelect = false;
                  }
                }
              });
            },
          ),
        ],
      ),
      body: LoadStateLayout(
        backgroundColor: AppColors.fff5f5f5,
        state: getLoadStateLayoutState(),
        errorRetry: load,
        successWidget: Column(
          children: <Widget>[
            Expanded(
              child: CustomRefreshLayout(
                enablePullUp: false,
                enablePullDown: isEditMode ? false : true,
                controller: refreshController,
                onRefresh: () async {
                  await updateCartInfo();
                  onRefresh();
                },
                child: ListView.separated(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 10),
                  itemBuilder: (context, index) {
                    CartProductInfoBean cartProductInfoBean =
                        CartDataManager.getInstance()
                            .cartInfoBean
                            .productList[index];

                    return Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                                padding: EdgeInsets.only(right: 15),
                                child: Icon(
                                  !isEditMode
                                      ? cartProductInfoBean.itemStatus == 1
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked
                                      : cartProductInfoBean.isEditSelect
                                          ? Icons.check_circle
                                          : Icons.radio_button_unchecked,
                                  color: !isEditMode
                                      ? cartProductInfoBean.itemStatus == 1
                                          ? Colors.red
                                          : AppColors.ff999999
                                      : cartProductInfoBean.isEditSelect
                                          ? Colors.red
                                          : AppColors.ff999999,
                                  size: 20,
                                )),
                            onTap: () {
                              _clickCheck(index, cartProductInfoBean);
                            },
                          ),
                          GestureDetector(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: CachedNetworkImage(
                                width: 100,
                                height: 100,
                                imageUrl: cartProductInfoBean.imageUrl ?? "",
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) => Container(
                                  width: 100,
                                  height: 100,
                                  color: AppColors.fff5f5f5,
                                ),
                              ),
                            ),
                            onTap: () {
                              _gotoProductDetails(cartProductInfoBean);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  child: Text(
                                    cartProductInfoBean.productName,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primary_text),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    _gotoProductDetails(cartProductInfoBean);
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                          text: "¥",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 13,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: cartProductInfoBean
                                                        ?.productPrice ??
                                                    "",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18)),
                                          ]),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    AddCartCountView(
                                      quantity: cartProductInfoBean.quantity,
                                      stock: cartProductInfoBean.stock,
                                      onChangeCount: (count) {
                                        cartProductInfoBean.quantity = count;
                                      },
                                      onEditTap: () {
                                        _isKeyboardShow = true;
                                        setState(() {});
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: CartDataManager.getInstance()
                          .cartInfoBean
                          ?.productList
                          ?.length ??
                      0,
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 10,
                    );
                  },
                ),
              ),
            ),
            _getBottomWidget(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _getBottomWidget() {
    bool isAllSelect = false;
    double totalPrice = 0.0;
    int i = 0;
    List<ConfirmOrderProductParams> productParamsList = [];
    if (CartDataManager.getInstance().cartInfoBean != null) {
      for (CartProductInfoBean cartProductInfoBean
          in CartDataManager.getInstance().cartInfoBean.productList) {
        if (!isEditMode) {
          if (cartProductInfoBean.itemStatus == 1) {
            i++;
            totalPrice += double.parse(cartProductInfoBean.productPrice) *
                cartProductInfoBean.quantity;

            ConfirmOrderProductParams confirmOrderProductParams = ConfirmOrderProductParams()
              ..productSkuId = cartProductInfoBean.productSkuId
              ..quantity = cartProductInfoBean.quantity;
            productParamsList.add(confirmOrderProductParams);
          }
        } else {
          if (cartProductInfoBean.isEditSelect) {
            i++;
          }
        }
      }
      if (i == CartDataManager.getInstance().cartInfoBean.productList?.length) {
        isAllSelect = true;
      }
    }

    Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1,
          color: AppColors.fff5f5f5,
        ),
        Container(
          height: 60,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Icon(
                  isAllSelect
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: isAllSelect ? Colors.red : AppColors.ff999999,
                  size: 20,
                ),
                onTap: () {
                  _clickAllCheck(!isAllSelect);
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              GestureDetector(
                child: Text(
                  S.of(context).all_check,
                  style: TextStyle(color: AppColors.primary_text, fontSize: 16),
                ),
                onTap: () {
                  _clickAllCheck(!isAllSelect);
                },
              ),
              Offstage(
                offstage: isEditMode,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    "${S.of(context).total_price} ¥$totalPrice",
                    style:
                        TextStyle(color: AppColors.primary_text, fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              !isEditMode
                  ? RaisedButton(
                      elevation: 0,
                      child: Container(
                        height: 42,
                        child: Center(
                            child: Text(
                          "${S.of(context).count}($i)",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        )),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      color: Colors.red,
                      onPressed: () {
                        if (i == 0) {
                          ToastUtils.show("请先选择商品");
                          return;
                        }
                        ConfirmOrderParams confirmOrderParams = ConfirmOrderParams();
                        confirmOrderParams.productList = productParamsList;
                        OrderPageManager.enterConfirmOrderPage(context, confirmOrderParams);
                      },
                    )
                  : GestureDetector(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            border: Border.all(
                                color: Colors.red, style: BorderStyle.solid)),
                        child: Text(
                          "删除",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onTap: () {
                        _deleteByCheck();
                      },
                    ),
            ],
          ),
        ),
      ],
    );

    return !_isKeyboardShow ? child : Container();
  }

  void _clickCheck(int index, CartProductInfoBean cartProductInfoBean) {
    if (!isEditMode) {
      if (cartProductInfoBean.itemStatus == 1) {
        cartProductInfoBean.itemStatus = 0;
      } else if (cartProductInfoBean.itemStatus == 0) {
        cartProductInfoBean.itemStatus = 1;
      }
    } else {
      cartProductInfoBean.isEditSelect = !cartProductInfoBean.isEditSelect;
    }

    setState(() {});
  }

  void _clickAllCheck(bool allCheck) {
    if (!isEditMode) {
      if (CartDataManager.getInstance().cartInfoBean != null) {
        for (CartProductInfoBean cartProductInfoBean
            in CartDataManager.getInstance().cartInfoBean.productList) {
          cartProductInfoBean.itemStatus = allCheck ? 1 : 0;
        }

        setState(() {});
      }
    } else {
      if (CartDataManager.getInstance().cartInfoBean != null) {
        for (CartProductInfoBean cartProductInfoBean
            in CartDataManager.getInstance().cartInfoBean.productList) {
          cartProductInfoBean.isEditSelect = allCheck;
        }

        setState(() {});
      }
    }
  }

  //删除选中的
  void _deleteByCheck() {
    List<int> productSkuIds = [];
    for (CartProductInfoBean infoBean
        in CartDataManager.getInstance().cartInfoBean.productList) {
      if (infoBean.isEditSelect) {
        productSkuIds.add(infoBean.productSkuId);
      }
    }

    if (productSkuIds.isEmpty) {
      ToastUtils.show("未选中商品");
      return;
    }

    final HDialog hDialog = CommonDialogUtils.showCommonDialog(
        "确定要删除这${productSkuIds.length}种商品吗？", "取消", null, "确定", () {
      CartNetUtils.deleteFromCart(productSkuIds).then((value) {
        ToastUtils.show(value.message);
        load();
      }).catchError((onError) {
        ToastUtils.show(onError.message);
      });
    });
  }

  @override
  Future<List<CartProductInfoBean>> getData(int page, int pageSize) async {
    CartDataManager.getInstance().cartInfoBean =
        await CartNetUtils.getCartInfo();
    CartDataManager.getInstance().originCartInfoBean =
        CartInfoBean(cartInfoBean: CartDataManager.getInstance().cartInfoBean);
    return CartDataManager.getInstance().cartInfoBean.productList;
  }

  @override
  void updateView() {
    if (mounted) {
      setState(() {});
    }
  }

  void _gotoProductDetails(CartProductInfoBean cartProductInfoBean) {
    ProductDetailParam productDetailParam = ProductDetailParam()
      ..productSkuId = cartProductInfoBean.productSkuId;
    ProductManager.goToProductDetail(context, productDetailParam);
  }

  Future<bool> updateCartInfo() async {
    return CartDataManager.getInstance().updateCartInfo();
  }
}
