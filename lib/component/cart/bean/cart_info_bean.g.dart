// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_info_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartInfoBean _$CartInfoBeanFromJson(Map<String, dynamic> json) {
  return CartInfoBean()
    ..productList = (json['productList'] as List)
        ?.map((e) => e == null
            ? null
            : CartProductInfoBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CartInfoBeanToJson(CartInfoBean instance) =>
    <String, dynamic>{
      'productList': instance.productList,
    };

CartProductInfoBean _$CartProductInfoBeanFromJson(Map<String, dynamic> json) {
  return CartProductInfoBean()
    ..brandId = json['brandId'] as String
    ..categoryId = json['categoryId'] as String
    ..imageUrl = json['imageUrl'] as String
    ..itemStatus = json['itemStatus'] as int
    ..productName = json['productName'] as String
    ..productOrgPrice = json['productOrgPrice'] as String
    ..productPrice = json['productPrice'] as String
    ..productSkuId = json['productSkuId'] as int;
}

Map<String, dynamic> _$CartProductInfoBeanToJson(
        CartProductInfoBean instance) =>
    <String, dynamic>{
      'brandId': instance.brandId,
      'categoryId': instance.categoryId,
      'imageUrl': instance.imageUrl,
      'itemStatus': instance.itemStatus,
      'productName': instance.productName,
      'productOrgPrice': instance.productOrgPrice,
      'productPrice': instance.productPrice,
      'productSkuId': instance.productSkuId,
    };
