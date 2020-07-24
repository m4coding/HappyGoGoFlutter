// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailBean _$ProductDetailBeanFromJson(Map<String, dynamic> json) {
  return ProductDetailBean()
    ..brand = json['brand'] as String
    ..category = json['category'] as String
    ..imageUrls = (json['imageUrls'] as List)?.map((e) => e as String)?.toList()
    ..productName = json['productName'] as String
    ..productOrgPrice = json['productOrgPrice'] as String
    ..productPrice = json['productPrice'] as String
    ..productSkuId = json['productSkuId'] as int
    ..productSpuId = json['productSpuId'] as int
    ..stock = json['stock'] as int;
}

Map<String, dynamic> _$ProductDetailBeanToJson(ProductDetailBean instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'category': instance.category,
      'imageUrls': instance.imageUrls,
      'productName': instance.productName,
      'productOrgPrice': instance.productOrgPrice,
      'productPrice': instance.productPrice,
      'productSkuId': instance.productSkuId,
      'productSpuId': instance.productSpuId,
      'stock': instance.stock,
    };
