
///确认订单-商品入参
class ConfirmOrderParams {
  List<ConfirmOrderProductParams> productList;
}

class ConfirmOrderProductParams {
  int productSkuId; //商品id
  int quantity; //加购的商品数量
}