// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeTopContentBean _$HomeTopContentBeanFromJson(Map<String, dynamic> json) {
  return HomeTopContentBean()
    ..sections = (json['sections'] as List)
        ?.map((e) =>
            e == null ? null : SectionBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$HomeTopContentBeanToJson(HomeTopContentBean instance) =>
    <String, dynamic>{
      'sections': instance.sections,
    };

SectionBean _$SectionBeanFromJson(Map<String, dynamic> json) {
  return SectionBean()
    ..viewType = json['viewType'] as String
    ..body = json['body'];
}

Map<String, dynamic> _$SectionBeanToJson(SectionBean instance) =>
    <String, dynamic>{
      'viewType': instance.viewType,
      'body': instance.body,
    };

BodyGalleryBean _$BodyGalleryBeanFromJson(Map<String, dynamic> json) {
  return BodyGalleryBean()
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : GalleryChildBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BodyGalleryBeanToJson(BodyGalleryBean instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

GalleryChildBean _$GalleryChildBeanFromJson(Map<String, dynamic> json) {
  return GalleryChildBean()
    ..imageUrl = json['imageUrl'] as String
    ..actionUrl = json['actionUrl'] as String;
}

Map<String, dynamic> _$GalleryChildBeanToJson(GalleryChildBean instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'actionUrl': instance.actionUrl,
    };

BodyTabChannelBean _$BodyTabChannelBeanFromJson(Map<String, dynamic> json) {
  return BodyTabChannelBean()
    ..items = (json['items'] as List)
        ?.map((e) => e == null
            ? null
            : TabChannelChildBean.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$BodyTabChannelBeanToJson(BodyTabChannelBean instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

TabChannelChildBean _$TabChannelChildBeanFromJson(Map<String, dynamic> json) {
  return TabChannelChildBean()
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..type = json['type'] as String;
}

Map<String, dynamic> _$TabChannelChildBeanToJson(
        TabChannelChildBean instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'type': instance.type,
    };
