
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PageBean{
  int pageNum;
  int pageSize;
  int totalPage;
  int total;
}