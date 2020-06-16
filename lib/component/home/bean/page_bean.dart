
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PageBean{
  int pageNum; //页码
  int pageSize; //每页个数
  int totalPage; //总页数
  int total; //总个数
}