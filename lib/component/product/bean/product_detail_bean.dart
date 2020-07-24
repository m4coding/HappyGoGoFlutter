
import 'package:json_annotation/json_annotation.dart';

part 'product_detail_bean.g.dart';

///商品详情bean
@JsonSerializable()
class ProductDetailBean {
  String brand; //品牌名称
  String category; //分类名称
  List<String> imageUrls; //商品图片集合
  String productName; //商品名称
  String productOrgPrice; //商品原始价格
  String productPrice; //商品销售价格
  int productSkuId; //商品Id
  int productSpuId; //spu Id
  int stock; //库存

  ProductDetailBean();

  factory ProductDetailBean.fromJson(Map<String, dynamic> json) => _$ProductDetailBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailBeanToJson(this);
}