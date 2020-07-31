
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/dialog/h_dialog.dart';
import 'package:happy_go_go_flutter/component/cart/net/cart_net_utils.dart';
import 'package:happy_go_go_flutter/component/cart/widgets/add_cart_count_view.dart';
import 'package:happy_go_go_flutter/component/product/bean/product_detail_bean.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///商品详情页-购物车弹窗
class ProductDetailShoppingDialog {
  ///显示弹窗
  static show(ProductDetailBean productDetailBean) {

    GlobalKey<AddCartCountViewState> addCartViewKey = GlobalKey();

    HDialog hDialog = HDialog().build()
      ..barrierDismissible = true
      ..canBackDismissible = true
      ..width = double.infinity
      ..height = MediaQuery.of(HDialog.getContext()).size.height / 2.35
      ..decoration = BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)))
      ..gravity = Gravity.bottom
      ..fitKeyBoard = true
      ..widget(Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                  height: 150,
                  width: 150,
                  imageUrl: productDetailBean.imageUrls[0] ?? "",
                  fit: BoxFit.contain,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Column(
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
                                  text: productDetailBean?.productPrice ?? "",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        "库存：${productDetailBean?.stock}",
                        style: TextStyle(
                            color: AppColors.secondary_text, fontSize: 13),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Text("购买数量", style: TextStyle(color: AppColors.primary_text, fontSize: 15),),
                Expanded(child: Container(),),
                AddCartCountView(key: addCartViewKey, stock: productDetailBean.stock,)
              ],
            ),
          ),
        ],
      ))
      ..divider(color: Colors.transparent, height: 20.0);

    hDialog
      ..widget(Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: RaisedButton(
          elevation: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
            child: Center(
                child: Text(
                  S.of(HDialog.getContext()).add_to_cart,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100)),
          color: Colors.red,
          onPressed: () {
            //加入购物车
            int quantity = addCartViewKey.currentState.getQuantity();
            CartNetUtils.addCart(productDetailBean.productSkuId, quantity).then((value){
              ToastUtils.show(value.message);
              hDialog.dismiss();
            }).catchError((onError){
              ToastUtils.show(onError.message);
            });
          },
        ),
      ))
      ..show();
  }
}
