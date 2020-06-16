// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryBean _$CategoryBeanFromJson(Map<String, dynamic> json) {
  return CategoryBean()
    ..pageNum = json['pageNum'] as int
    ..pageSize = json['pageSize'] as int
    ..totalPage = json['totalPage'] as int
    ..total = json['total'] as int
    ..list = (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryChildBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CategoryBeanToJson(CategoryBean instance) =>
    <String, dynamic>{
      'pageNum': instance.pageNum,
      'pageSize': instance.pageSize,
      'totalPage': instance.totalPage,
      'total': instance.total,
      'list': instance.list,
    };

CategoryChildBean _$CategoryChildBeanFromJson(Map<String, dynamic> json) {
  return CategoryChildBean()
    ..name = json['name'] as String
    ..categoryId = json['categoryId'] as int
    ..childCategoryList = (json['childCategoryList'] as List)
        ?.map((e) => e == null
            ? null
            : CategoryChildBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CategoryChildBeanToJson(CategoryChildBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categoryId': instance.categoryId,
      'childCategoryList': instance.childCategoryList,
    };
