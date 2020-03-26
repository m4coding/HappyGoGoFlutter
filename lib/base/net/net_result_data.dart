
///网络结果数据
class NetResultData {
  Map data;
  List listData;
  int code;
  String message;
  bool isSuccess;

  NetResultData(this.listData, this.data, this.code, this.message, this.isSuccess);
}

///直接处理转换为bean数据
class NetResultProcessData<B> {
  B data;
  List<B> listData;
  int code;
  String message;
  bool isSuccess;

  NetResultProcessData(this.listData, this.data, this.code, this.message, this.isSuccess);
}

abstract class BaseBean {
  Object fromJson(Map<String, dynamic> json);
}