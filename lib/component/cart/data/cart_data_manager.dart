import 'package:happy_go_go_flutter/base/net/net_result_data.dart';
import 'package:happy_go_go_flutter/component/cart/bean/cart_info_bean.dart';
import 'package:happy_go_go_flutter/component/cart/bean/cart_update_params.dart';
import 'package:happy_go_go_flutter/component/cart/net/cart_net_utils.dart';

class CartDataManager {
  CartInfoBean originCartInfoBean;
  CartInfoBean cartInfoBean;

  static CartDataManager _cartDataManager;

  static CartDataManager getInstance() {
    if (_cartDataManager == null) {
      _cartDataManager = CartDataManager._internal();
    }

    return _cartDataManager;
  }

  CartDataManager._internal();

  ///更新购物车
  Future<bool> updateCartInfo() async {
    if (cartInfoBean?.productList?.isNotEmpty == true &&
        originCartInfoBean?.productList?.isNotEmpty == true) {
      List<CartProductInfoBean> updateList = [];
      for (CartProductInfoBean infoBean in cartInfoBean.productList) {
        for (CartProductInfoBean originInfoBean
            in originCartInfoBean.productList) {
          if (infoBean.productSkuId == originInfoBean.productSkuId) {
            if (infoBean.itemStatus != originInfoBean.itemStatus) {
              updateList.add(infoBean);
              break;
            }

            if (infoBean.quantity != originInfoBean.quantity) {
              updateList.add(infoBean);
              break;
            }
          }
        }
      }

      if (updateList.isNotEmpty) {
        List<CartUpdateParams> list = [];
        for (CartProductInfoBean infoBean in updateList) {
          list.add(CartUpdateParams()
            ..productSkuId = infoBean.productSkuId
            ..quantity = infoBean.quantity
            ..itemStatus = infoBean.itemStatus);
        }
        NetResultData netResultData = await CartNetUtils.updateCartInfo(list);
        if (netResultData.isSuccess) {
          return true;
        }
      }
    }

    return false;
  }
}
