// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_product_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPageBean _$ProductPageBeanFromJson(Map<String, dynamic> json) {
  return ProductPageBean()
    ..pageNum = json['pageNum'] as int
    ..pageSize = json['pageSize'] as int
    ..totalPage = json['totalPage'] as int
    ..total = json['total'] as int
    ..list = (json['list'] as List)
        ?.map((e) =>
            e == null ? null : ProductBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ProductPageBeanToJson(ProductPageBean instance) =>
    <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'totalPage': instance.totalPage,
      'total': instance.total,
      'list': instance.list,
    };

ProductBean _$ProductBeanFromJson(Map<String, dynamic> json) {
  return ProductBean()
    ..viewType = json['viewType'] as String
    ..body = json['body'] == null
        ? null
        : BodyProductBean.fromJson(json['body'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ProductBeanToJson(ProductBean instance) =>
    <String, dynamic>{
      'viewType': instance.viewType,
      'body': instance.body,
    };

BodyProductBean _$BodyProductBeanFromJson(Map<String, dynamic> json) {
  return BodyProductBean()
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : ProductChildBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BodyProductBeanToJson(BodyProductBean instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

ProductChildBean _$ProductChildBeanFromJson(Map<String, dynamic> json) {
  return ProductChildBean()
    ..imageUrl = json['imageUrl'] as String
    ..productName = json['productName'] as String
    ..productOrgPrice = json['productOrgPrice'] as String
    ..productPrice = json['productPrice'] as String
    ..productSkuId = json['productSkuId'] as int
    ..productSpuId = json['productSpuId'] as int;
}

Map<String, dynamic> _$ProductChildBeanToJson(ProductChildBean instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'productName': instance.productName,
      'productOrgPrice': instance.productOrgPrice,
      'productPrice': instance.productPrice,
      'productSkuId': instance.productSkuId,
      'productSpuId': instance.productSpuId,
    };
