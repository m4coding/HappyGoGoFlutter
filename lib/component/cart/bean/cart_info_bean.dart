
import 'package:json_annotation/json_annotation.dart';

part 'cart_info_bean.g.dart';

///购物车信息Bean
@JsonSerializable()
class CartInfoBean {
  List<CartProductInfoBean> productList; //商品列表

  CartInfoBean({CartInfoBean cartInfoBean}) {
    if (cartInfoBean != null) {
      this.productList = [];
      for (CartProductInfoBean cartProductInfoBean in cartInfoBean.productList) {
        CartProductInfoBean temp = CartProductInfoBean()
          ..quantity = cartProductInfoBean.quantity
          ..productSkuId = cartProductInfoBean.productSkuId
          ..itemStatus = cartProductInfoBean.itemStatus;

        productList.add(temp);
      }
    }
  }

  factory CartInfoBean.fromJson(Map<String, dynamic> json) => _$CartInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$CartInfoBeanToJson(this);
}

@JsonSerializable()
class CartProductInfoBean {
  String brandId; //品牌id
  String categoryId; //分类id
  String imageUrl; //商品图片
  int itemStatus; //商品的选中状态，0表示未选中，1表示选中
  String productName; //商品名称
  String productOrgPrice; //商品原始价格
  String productPrice; //商品现在的价格
  int productSkuId; //商品sku id
  int stock; //商品库存
  int quantity; //在购物车中的数量

  CartProductInfoBean();

  factory CartProductInfoBean.fromJson(Map<String, dynamic> json) => _$CartProductInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$CartProductInfoBeanToJson(this);
}