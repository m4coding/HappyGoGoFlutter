import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/bar/common_bar.dart';
import 'package:happy_go_go_flutter/component/order/bean/confirm_order_info_bean.dart';
import 'package:happy_go_go_flutter/component/order/bean/confirm_order_params.dart';
import 'package:happy_go_go_flutter/component/order/net/order_net_utils.dart';
import 'package:happy_go_go_flutter/component/person/bean/my_address_bean.dart';
import 'package:happy_go_go_flutter/component/person/bean/user_receiver_address_bean.dart';
import 'package:happy_go_go_flutter/component/person/net/person_net_utils.dart';
import 'package:happy_go_go_flutter/component/person/person_page_manager.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///确认订单页
class ConfirmOrderPage extends StatefulWidget {
  final ConfirmOrderParams confirmOrderParams;

  static newInstance(
      BuildContext context, ConfirmOrderParams confirmOrderParams) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return ConfirmOrderPage(confirmOrderParams);
      },
    ));
  }

  ConfirmOrderPage(this.confirmOrderParams);

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  ConfirmOrderInfoBean _confirmOrderInfoBean;

  @override
  void initState() {
    super.initState();
    _getNetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonBar(
          title: S.of(context).confirm_order,
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              CustomScrollView(
                slivers: <Widget>[
                  _getAddressLayout(),
                  _getProductLayout(),
                  _getOtherInfoLayout(),
                ],
              ),
              Align(
                  alignment: Alignment.bottomCenter, child: _getBottomLayout()),
            ],
          ),
        ));
  }

  //地址 item
  Widget _getAddressLayout() {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: (){
          PersonPageManager.enterMyAddressPage(context).then((value){
            if (_confirmOrderInfoBean?.userReceiverAddress == null) {
              _confirmOrderInfoBean?.userReceiverAddress = UserReceiverAddressBean();
            }
            _confirmOrderInfoBean?.userReceiverAddress?.name = value.receiverName;
            _confirmOrderInfoBean?.userReceiverAddress?.phoneNumber = value.receiverPhone;
            _confirmOrderInfoBean?.userReceiverAddress?.detailAddress = value.receiverAddr;
            _confirmOrderInfoBean?.userReceiverAddress?.defaultStatus = value.isDefault;

            setState(() {

            });
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                    children: <Widget>[
                      Offstage(
                        child: Text(
                          "选择收货地址",
                          style: TextStyle(
                              color: AppColors.primary_text, fontSize: 18),
                        ),
                        offstage:
                            _confirmOrderInfoBean?.userReceiverAddress != null,
                      ),
                      Offstage(
                        offstage:
                            _confirmOrderInfoBean?.userReceiverAddress == null,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _confirmOrderInfoBean
                                      ?.userReceiverAddress?.detailAddress ??
                                  "",
                              style: TextStyle(
                                  color: AppColors.primary_text, fontSize: 18),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _confirmOrderInfoBean
                                          ?.userReceiverAddress?.name ??
                                      "",
                                  style: TextStyle(
                                      color: AppColors.secondary_text,
                                      fontSize: 14),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                ),
                                Text(
                                  _confirmOrderInfoBean
                                          ?.userReceiverAddress?.phoneNumber ??
                                      "",
                                  style: TextStyle(
                                      color: AppColors.secondary_text,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primary_text,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  //获取商品列表
  Widget _getProductLayout() {
    int length = _confirmOrderInfoBean?.productList?.length ?? 0;

    return length > 0
        ? SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
            ProductInfoBeanInOrder productInfoBeanInOrder =
                _confirmOrderInfoBean?.productList[index];
            bool isFirstItem = index == 0;
            bool isLastItem =
                index == (_confirmOrderInfoBean?.productList?.length ?? 0) - 1;
            return Container(
              height: 130,
              margin: EdgeInsets.only(
                  left: 10, right: 10, top: isFirstItem ? 10 : 0, bottom: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(isFirstItem ? 8.0 : 0.0),
                    topRight: Radius.circular(isFirstItem ? 8.0 : 0.0),
                    bottomLeft: Radius.circular(isLastItem ? 8.0 : 0.0),
                    bottomRight: Radius.circular(isLastItem ? 8.0 : 0.0)),
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: isLastItem ? 10 : 0),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1 / 1,
                        child: CachedNetworkImage(
                          imageUrl: productInfoBeanInOrder.imageUrl ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                productInfoBeanInOrder.productName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: AppColors.primary_text),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      "¥${productInfoBeanInOrder.productPrice}",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "x${productInfoBeanInOrder.quantity}",
                                    style: TextStyle(
                                      color: AppColors.secondary_text,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }, childCount: _confirmOrderInfoBean?.productList?.length ?? 0))
        : SliverToBoxAdapter(child: Container());
  }

  //其他信息layout
  Widget _getOtherInfoLayout() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 75),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "商品总金额",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.primary_text),
                  ),
                ),
                Text(
                  "¥${_confirmOrderInfoBean?.calculateSum?.totalProductAmount ?? "0.00"}",
                  style: TextStyle(fontSize: 16, color: AppColors.primary_text),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "运费",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.primary_text),
                  ),
                ),
                Text(
                  "¥${_confirmOrderInfoBean?.calculateSum?.freightAmount ?? "0.00"}",
                  style: TextStyle(fontSize: 16, color: AppColors.primary_text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBottomLayout() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            "¥${_confirmOrderInfoBean?.calculateSum?.totalProductAmount ?? "0.00"}",
            style: TextStyle(color: Colors.red, fontSize: 18),
          )),
          RaisedButton(
            elevation: 0,
            child: Container(
              height: 40,
              child: Center(
                  child: Text(
                S.of(context).confirm,
                style: TextStyle(color: Colors.white, fontSize: 21),
                textAlign: TextAlign.center,
              )),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            color: Colors.red,
            onPressed: () {},
          )
        ],
      ),
    );
  }

  void _getNetData() {
    OrderNetUtils.getConfirmOrderInfo(widget.confirmOrderParams).then((value) {
      _confirmOrderInfoBean = value;
      setState(() {});
    }).catchError((onError, stackTrace) {
      print(stackTrace.toString());
      ToastUtils.show(onError.toString());
    });
  }
}
