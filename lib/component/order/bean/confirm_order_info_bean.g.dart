// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_order_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmOrderInfoBean _$ConfirmOrderInfoBeanFromJson(Map<String, dynamic> json) {
  return ConfirmOrderInfoBean()
    ..productList = (json['productList'] as List)
        ?.map((e) => e == null
            ? null
            : ProductInfoBeanInOrder.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..userReceiverAddress = json['userReceiverAddress'] == null
        ? null
        : UserReceiverAddressBean.fromJson(
            json['userReceiverAddress'] as Map<String, dynamic>)
    ..calculateSum = json['calculateSum'] == null
        ? null
        : OrderCalculateSumBean.fromJson(
            json['calculateSum'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ConfirmOrderInfoBeanToJson(
        ConfirmOrderInfoBean instance) =>
    <String, dynamic>{
      'productList': instance.productList,
      'userReceiverAddress': instance.userReceiverAddress,
      'calculateSum': instance.calculateSum,
    };

ProductInfoBeanInOrder _$ProductInfoBeanInOrderFromJson(
    Map<String, dynamic> json) {
  return ProductInfoBeanInOrder()
    ..imageUrl = json['imageUrl'] as String
    ..productName = json['productName'] as String
    ..productOrgPrice = json['productOrgPrice'] as String
    ..productPrice = json['productPrice'] as String
    ..productSkuId = json['productSkuId'] as int
    ..quantity = json['quantity'] as int;
}

Map<String, dynamic> _$ProductInfoBeanInOrderToJson(
        ProductInfoBeanInOrder instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'productName': instance.productName,
      'productOrgPrice': instance.productOrgPrice,
      'productPrice': instance.productPrice,
      'productSkuId': instance.productSkuId,
      'quantity': instance.quantity,
    };

OrderCalculateSumBean _$OrderCalculateSumBeanFromJson(
    Map<String, dynamic> json) {
  return OrderCalculateSumBean()
    ..freightAmount = (json['freightAmount'] as num)?.toDouble()
    ..payAmount = (json['payAmount'] as num)?.toDouble()
    ..totalProductAmount = (json['totalProductAmount'] as num)?.toDouble();
}

Map<String, dynamic> _$OrderCalculateSumBeanToJson(
        OrderCalculateSumBean instance) =>
    <String, dynamic>{
      'freightAmount': instance.freightAmount,
      'payAmount': instance.payAmount,
      'totalProductAmount': instance.totalProductAmount,
    };
