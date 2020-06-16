import 'package:happy_go_go_flutter/component/home/bean/page_bean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_bean.g.dart';

@JsonSerializable()
class CategoryBean extends PageBean {
  List<CategoryChildBean> list; //分类列表
  CategoryBean();

  factory CategoryBean.fromJson(Map<String, dynamic> json) => _$CategoryBeanFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryBeanToJson(this);
}

@JsonSerializable()
class CategoryChildBean {
  String name; //分类名称
  int categoryId; //分类id
  List<CategoryChildBean> childCategoryList;

  CategoryChildBean();

  factory CategoryChildBean.fromJson(Map<String, dynamic> json) => _$CategoryChildBeanFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryChildBeanToJson(this);
}