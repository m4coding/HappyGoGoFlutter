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
  static newInstance(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
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
          child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {

              AddressBean addressBean = _myAddressBean.addressList[index];

              return Container(
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(addressBean?.receiverName ?? "", style: TextStyle(fontSize: 16, color: AppColors.primary_text, fontWeight: FontWeight.bold),),
                      Padding(padding: EdgeInsets.only(left: 5),),
                      Text(addressBean?.receiverPhone ?? "", style: TextStyle(fontSize: 16, color: AppColors.primary_text, fontWeight: FontWeight.bold)),
                      Padding(padding: EdgeInsets.only(left: 5),),
                      Container(child: Text("", style: TextStyle(fontSize: 16, color: AppColors.white))),
                    ]),
                    Row(
                      children: <Widget>[
                        Text(addressBean?.receiverAddr ?? "", style: TextStyle(fontSize: 16, color: AppColors.secondary_text)),
                        Expanded(child: Icon(Icons.edit, size: 15,),)
                      ],
                    )
                  ],
                ),
              );
            }, itemCount: _myAddressBean?.addressList?.length ?? 0,),
          ),
          Container(
            margin: EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 20),
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
                PersonPageManager.enterAddAddressPage(context);
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
