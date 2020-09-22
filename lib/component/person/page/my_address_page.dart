import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/bar/common_bar.dart';
import 'package:happy_go_go_flutter/component/person/bean/my_address_bean.dart';
import 'package:happy_go_go_flutter/component/person/net/person_net_utils.dart';
import 'package:happy_go_go_flutter/component/person/person_page_manager.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///我的地址页
class MyAddressPage extends StatefulWidget {
  static Future<AddressBean> newInstance(BuildContext context) {
    return Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return MyAddressPage();
      },
    ));
  }

  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  MyAddressBean _myAddressBean;

  @override
  void initState() {
    super.initState();

    _getNetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBar(
        title: S.of(context).shipping_address,
      ),
      body: Container(
          color: AppColors.fff5f5f5,
          child: Column(
            children: <Widget>[
              Container(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    AddressBean addressBean = _myAddressBean.addressList[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, addressBean);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        color: AppColors.white,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(
                                      addressBean?.receiverName ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.primary_text,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Text(addressBean?.receiverPhone ?? "",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.primary_text,
                                            fontWeight: FontWeight.bold)),
                                    Padding(
                                      padding: EdgeInsets.only(left: 5),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                            addressBean.isDefault == 1 ? "默认" : "",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: AppColors.primary))),
                                  ]),
                                  Text(addressBean.receiverRegion,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.secondary_text)),
                                  Text(addressBean?.receiverAddr ?? "",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.secondary_text)),
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: Container(
                                child: Icon(
                                  Icons.edit,
                                  size: 25,
                                  color: AppColors.secondary_text,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8),
                              ),
                              onTap: () {
                                PersonPageManager.enterAddAddressPage(context, addressBean: addressBean)
                                    .then((value) {
                                  if (value) {
                                    _getNetData();
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _myAddressBean?.addressList?.length ?? 0,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 10,
                    );
                  },
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 20),
                child: RaisedButton(
                  elevation: 0,
                  child: Container(
                    height: 48,
                    child: Center(
                        child: Text(
                      S.of(context).add_shipping_address,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    )),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  color: Colors.red,
                  onPressed: () {
                    PersonPageManager.enterAddAddressPage(context)
                        .then((value) {
                      if (value) {
                        _getNetData();
                      }
                    });
                  },
                ),
              )
            ],
          )),
    );
  }

  void _getNetData() {
    PersonNetUtils.getMyAddressList().then((value) {
      setState(() {
        _myAddressBean = value;
      });
    }).catchError((onError) {
      ToastUtils.show(onError.toString());
    });
  }
}
