
import 'package:json_annotation/json_annotation.dart';

part 'cart_update_params.g.dart';

///更新购物车入参
@JsonSerializable()
class CartUpdateParams {
  int itemStatus; //商品在购物车中的状态: 0-新增（未选中）, 1-选中
  int productSkuId; //商品id
  int quantity; //加购的商品数量

  CartUpdateParams();

  factory CartUpdateParams.fromJson(Map<String, dynamic> json) => _$CartUpdateParamsFromJson(json);
  Map<String, dynamic> toJson() => _$CartUpdateParamsToJson(this);
}