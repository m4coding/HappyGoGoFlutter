/**
 * 网络结果数据
 */
class NetResultData {
  Map data;
  List listData;
  String code;
  String message;
  bool isSuccess;

  NetResultData(this.listData, this.data, this.code, this.message, this.isSuccess);
}
