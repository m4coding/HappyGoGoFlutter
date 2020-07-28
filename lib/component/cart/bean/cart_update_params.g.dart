// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_update_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartUpdateParams _$CartUpdateParamsFromJson(Map<String, dynamic> json) {
  return CartUpdateParams()
    ..itemStatus = json['itemStatus'] as int
    ..productSkuId = json['productSkuId'] as int
    ..quantity = json['quantity'] as int;
}

Map<String, dynamic> _$CartUpdateParamsToJson(CartUpdateParams instance) =>
    <String, dynamic>{
      'itemStatus': instance.itemStatus,
      'productSkuId': instance.productSkuId,
      'quantity': instance.quantity,
    };
