import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/utils/common_utils.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/bar/common_bar.dart';
import 'package:happy_go_go_flutter/base/widgets/dialog/common_dialog_utils.dart';
import 'package:happy_go_go_flutter/component/person/bean/address_params.dart';
import 'package:happy_go_go_flutter/component/person/bean/my_address_bean.dart';
import 'package:happy_go_go_flutter/component/person/dialog/address_area_dialog.dart';
import 'package:happy_go_go_flutter/component/person/net/person_net_utils.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///添加地址页
class AddAddressPage extends StatefulWidget {
  static Future<bool> newInstance(
      BuildContext context, AddressBean addressBean) {
    return Navigator.push(context, MaterialPageRoute(
      builder: (_) {
        return AddAddressPage(
          addressBean: addressBean,
        );
      },
    ));
  }

  final AddressBean addressBean;

  AddAddressPage({this.addressBean});

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController,
      _regionController,
      _phoneController,
      _nameController;

  AreaDialogTitleBean _areaDialogTitleBean;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController();
    _regionController = TextEditingController();
    _phoneController = TextEditingController();
    _nameController = TextEditingController();

    _addressController.text = widget.addressBean?.receiverAddr ?? "";
    _regionController.text = widget.addressBean?.receiverRegion ?? "";
    _phoneController.text = widget.addressBean?.receiverPhone ?? "";
    _nameController.text = widget.addressBean?.receiverName ?? "";
    _isDefault = widget.addressBean?.isDefault == 1 ?? false;
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
        rightDMActions: widget.addressBean != null
            ? <Widget>[
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      "删除",
                      style: TextStyle(
                          color: AppColors.primary_text, fontSize: 17),
                    )),
                  ),
                  onTap: () {
                    CommonDialogUtils.showCommonDialog("确认要删除此地址吗？", "取消", () {
                    }, "确认", () {
                      PersonNetUtils.deleteAddress(
                          int.parse(widget.addressBean.addressId))
                          .then((value) {
                        ToastUtils.show("删除地址成功");
                        Navigator.pop(context, true);
                      }).catchError((onError, stakeTrace) {
                        print(stakeTrace.toString());
                        ToastUtils.show(onError.toString());
                      });
                    });
                  },
                )
              ]
            : [],
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
                      _areaDialogTitleBean = titleBean;
                      _regionController.text = titleBean.title;
                      setState(() {});
                    });
                  }),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  _getItem("详细地址", "请输入详情地址", false, _addressController),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Text(
                          "设置为默认地址",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.primary_text),
                        )),
                        Switch(
                          value: _isDefault,
                          onChanged: (isCheck) {
                            setState(() {
                              _isDefault = isCheck;
                            });
                          },
                        ),
                      ],
                    ),
                  )
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

                  if (!CommonUtils.isChinaPhoneLegal(_phoneController.text)) {
                    ToastUtils.show("请输入正确的手机号");
                    return;
                  }

                  AddressParams addressParams = AddressParams();
                  addressParams.receiverAddr = _addressController.text;
                  addressParams.receiverName = _nameController.text;
                  addressParams.receiverPhone = _phoneController.text;
                  addressParams.receiverRegion = _regionController.text;
                  addressParams.isDefault = _isDefault ? 1 : 0;

                  if (widget.addressBean != null) {
                    addressParams.addressId =
                        int.parse(widget.addressBean.addressId);
                    PersonNetUtils.editAddress(addressParams).then((value) {
                      ToastUtils.show("编辑地址成功");
                      Navigator.pop(context, true);
                    }).catchError((onError) {
                      ToastUtils.show(onError.toString());
                    });
                  } else {
                    addressParams.addressId =
                        int.parse(_areaDialogTitleBean?.addressAreaBean?.id);

                    PersonNetUtils.addAddress(addressParams).then((value) {
                      ToastUtils.show("新增地址成功");
                      Navigator.pop(context, true);
                    }).catchError((onError) {
                      ToastUtils.show(onError.toString());
                    });
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
              child: readOnly
                  ? SingleChildScrollView(
                      //包装个SingleChildScrollView，为的是Text能显示内容过多时能左右滚动
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        textEditingController?.text?.isNotEmpty == true
                            ? textEditingController.text
                            : hint,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                textEditingController?.text?.isNotEmpty == true
                                    ? AppColors.primary_text
                                    : AppColors.ff999999),
                      ),
                    )
                  : TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle:
                            TextStyle(fontSize: 15, color: AppColors.ff999999),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                          fontSize: 15, color: AppColors.primary_text),
                    ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Offstage(
                offstage: !needArrow,
                child: Icon(Icons.keyboard_arrow_right,
                    color: textEditingController?.text?.isNotEmpty == true
                        ? AppColors.primary_text
                        : AppColors.ff999999))
          ],
        ),
      ),
    );
  }
}
