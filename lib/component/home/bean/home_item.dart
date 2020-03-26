
import 'package:json_annotation/json_annotation.dart';

part 'home_item.g.dart';


@JsonSerializable()
class HomeTopContentBean {

  static const String VIEW_TYPE_GALLERY = "gallery";
  static const String VIEW_TYPE_TAB_CHANNEL = "tab_channel";

  List<SectionBean> sections;

  HomeTopContentBean();

  factory HomeTopContentBean.fromJson(Map<String, dynamic> json) => _$HomeTopContentBeanFromJson(json);
  Map<String, dynamic> toJson() => _$HomeTopContentBeanToJson(this);
}

@JsonSerializable()
class SectionBean {
  String viewType;
  dynamic body;

  SectionBean();

  factory SectionBean.fromJson(Map<String, dynamic> json) => _$SectionBeanFromJson(json);
  Map<String, dynamic> toJson() => _$SectionBeanToJson(this);
}

///viewtype: gallery
@JsonSerializable()
class BodyGalleryBean {
  List<GalleryChildBean> items;

  BodyGalleryBean();

  factory BodyGalleryBean.fromJson(Map<String, dynamic> json) => _$BodyGalleryBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BodyGalleryBeanToJson(this);
}

@JsonSerializable()
class GalleryChildBean {
  String imageUrl;
  String actionUrl;

  GalleryChildBean();

  factory GalleryChildBean.fromJson(Map<String, dynamic> json) => _$GalleryChildBeanFromJson(json);
  Map<String, dynamic> toJson() => _$GalleryChildBeanToJson(this);
}

///viewtype: tab_channel
@JsonSerializable()
class BodyTabChannelBean {
  List<TabChannelChildBean> items;

  BodyTabChannelBean();

  factory BodyTabChannelBean.fromJson(Map<String, dynamic> json) => _$BodyTabChannelBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BodyTabChannelBeanToJson(this);
}

@JsonSerializable()
class TabChannelChildBean {
  String title;
  String subTitle;
  String type;

  TabChannelChildBean();

  factory TabChannelChildBean.fromJson(Map<String, dynamic> json) => _$TabChannelChildBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TabChannelChildBeanToJson(this);
}

