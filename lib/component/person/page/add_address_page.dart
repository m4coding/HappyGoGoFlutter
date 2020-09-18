
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/bar/common_bar.dart';
import 'package:happy_go_go_flutter/component/person/dialog/address_area_dialog.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///添加地址页
class AddAddressPage extends StatefulWidget {
  static newInstance(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return AddAddressPage();
      },
    ));
  }

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController,
      _regionController,
      _phoneController,
      _nameController;

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController();
    _regionController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _addressController?.dispose();
    _regionController?.dispose();
    _phoneController?.dispose();
    _nameController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonBar(
        title: S.of(context).add_shipping_address,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _getItem("收货人", "请输入收货人姓名", false, _nameController),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _getItem("手机号码", "请输入收货人手机号码", false, _phoneController),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _getItem("地区", "选择省市区", true, _regionController,
                      readOnly: true, onClick: () {
                        AddressAreaDialog.show((AreaDialogTitleBean titleBean) {
                          _regionController.text = titleBean.title;
                          setState(() {
                          });
                        });
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _getItem("详细地址", "请输入详情地址", false, _addressController),
                ],
              ),
            )),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 20),
              child: RaisedButton(
                elevation: 0,
                child: Container(
                  height: 48,
                  child: Center(
                      child: Text(
                    S.of(context).save,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  )),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                color: Colors.red,
                onPressed: () {
                  if (_nameController.text == null ||
                      _nameController.text.isEmpty) {
                    ToastUtils.show("请输入收货人姓名");
                    return;
                  }

                  if (_phoneController == null ||
                      _phoneController.text.isEmpty) {
                    ToastUtils.show("请输入收货人手机号码");
                    return;
                  }

                  if (_regionController == null ||
                      _regionController.text.isEmpty) {
                    ToastUtils.show("请选择省市区");
                    return;
                  }

                  if (_addressController == null ||
                      _addressController.text.isEmpty) {
                    ToastUtils.show("请输入详情地址");
                    return;
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getItem(String title, String hint, bool needArrow,
      TextEditingController textEditingController,
      {bool readOnly = false, String text, VoidCallback onClick}) {
    return GestureDetector(
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(color: AppColors.primary_text, fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Expanded(
              child: TextField(
                controller: textEditingController,
                readOnly: readOnly,
                enabled: !readOnly,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(fontSize: 15, color: AppColors.ff999999),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 15, color: AppColors.primary_text),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Offstage(
                offstage: !needArrow, child: Icon(Icons.keyboard_arrow_right))
          ],
        ),
      ),
    );
  }

}
