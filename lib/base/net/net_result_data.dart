
///网络结果数据
class NetResultData {
  Map data;
  List listData;
  int code;
  String message;
  bool isSuccess;
  Object otherData; //通用数据 不符合规则的数据（不是Map数据、也不是List数据）

  NetResultData(this.listData, this.data, this.code, this.message, this.isSuccess, {this.otherData});
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