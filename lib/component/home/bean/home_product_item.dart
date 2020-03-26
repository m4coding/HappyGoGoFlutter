
import 'package:happy_go_go_flutter/component/home/bean/page_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_product_item.g.dart';

@JsonSerializable()
class ProductPageBean extends PageBean {
  List<ProductBean> list;

  ProductPageBean();

  factory ProductPageBean.fromJson(Map<String, dynamic> json) => _$ProductPageBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ProductPageBeanToJson(this);
}

///viewtype: product_card
@JsonSerializable()
class ProductBean {

  static const String VIEW_TYPE_PRODUCT_CARD = "product_card";

  String viewType;
  BodyProductBean body;

  ProductBean();

  factory ProductBean.fromJson(Map<String, dynamic> json) => _$ProductBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ProductBeanToJson(this);
}

@JsonSerializable()
class BodyProductBean {
  List<ProductChildBean> items;

  BodyProductBean();

  factory BodyProductBean.fromJson(Map<String, dynamic> json) => _$BodyProductBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BodyProductBeanToJson(this);
}

@JsonSerializable()
class ProductChildBean {
  String imageUrl;
  String productName;
  String productOrgPrice;
  String productPrice;
  int productSkuId;
  int productSpuId;

  ProductChildBean();

  factory ProductChildBean.fromJson(Map<String, dynamic> json) => _$ProductChildBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ProductChildBeanToJson(this);

}


