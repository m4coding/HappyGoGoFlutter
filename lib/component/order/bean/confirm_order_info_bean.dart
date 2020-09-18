
import 'package:happy_go_go_flutter/component/person/bean/user_receiver_address_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_order_info_bean.g.dart';

///确认订单信息
@JsonSerializable()
class ConfirmOrderInfoBean {
  List<ProductInfoBeanInOrder> productList; //商品列表
  UserReceiverAddressBean userReceiverAddress; //默认的收货人信息
  OrderCalculateSumBean calculateSum;

  ConfirmOrderInfoBean();

  factory ConfirmOrderInfoBean.fromJson(Map<String, dynamic> json) => _$ConfirmOrderInfoBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmOrderInfoBeanToJson(this);
}


///商品信息
@JsonSerializable()
class ProductInfoBeanInOrder {
  String imageUrl; //商品图片
  String productName; //商品名称
  String productOrgPrice; //商品原始价格
  String productPrice; //商品现在的价格
  int productSkuId; //商品sku id
  int quantity; //数量

  ProductInfoBeanInOrder();

  factory ProductInfoBeanInOrder.fromJson(Map<String, dynamic> json) => _$ProductInfoBeanInOrderFromJson(json);
  Map<String, dynamic> toJson() => _$ProductInfoBeanInOrderToJson(this);
}

///价格计算相关信息
@JsonSerializable()
class OrderCalculateSumBean {
  double freightAmount; //运费
  double payAmount; //实付金额
  double totalProductAmount; //商品总金额

  OrderCalculateSumBean();

  factory OrderCalculateSumBean.fromJson(Map<String, dynamic> json) => _$OrderCalculateSumBeanFromJson(json);
  Map<String, dynamic> toJson() => _$OrderCalculateSumBeanToJson(this);
}