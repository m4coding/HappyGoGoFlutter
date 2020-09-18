import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/dialog/h_dialog.dart';
import 'package:happy_go_go_flutter/component/person/bean/address_area_bean.dart';
import 'package:happy_go_go_flutter/component/person/bean/address_area_params.dart';
import 'package:happy_go_go_flutter/component/person/net/person_net_utils.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///区域选择弹窗
class AddressAreaDialog {
  static void show(Function(AreaDialogTitleBean area) onSelect) {
    AddressAreaParams addressAreaParams = AddressAreaParams();
    PersonNetUtils.getAreaList(addressAreaParams).then((value) {
      List<AddressAreaBean> provinceAreaList = value;

      HDialog hDialog = HDialog().build()
        ..barrierDismissible = true
        ..canBackDismissible = true
        ..width = double.infinity
        ..height = MediaQuery.of(HDialog.getContext()).size.height / 2.1
        ..decoration = BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)))
        ..gravity = Gravity.bottom;

      hDialog.widget(_AreaDialogWidget(
        provinceAreaList,
        () {
          hDialog.dismiss();
        },
        onSelect: (AreaDialogTitleBean bean) {
          hDialog.dismiss();
          if (onSelect != null) {
            onSelect(bean);
          }
        },
      ));

      hDialog.show();
    }).catchError((onError) {
      ToastUtils.show(onError.toString());
    });
  }
}

class AreaDialogTitleBean {
  String title;
  AddressAreaBean addressAreaBean;
}

class _AreaDialogWidget extends StatefulWidget {
  List<AreaDialogTitleBean> tileList = [AreaDialogTitleBean()..title = "请选择"];

  int selectIndex = 0;

  Map<int, List<AddressAreaBean>> childMap = HashMap();

  final VoidCallback onCloseClick;

  Function(AreaDialogTitleBean area) onSelect;

  _AreaDialogWidget(List<AddressAreaBean> provinceAreaList, this.onCloseClick,
      {this.onSelect}) {
    selectIndex = 0;
    childMap[selectIndex] = provinceAreaList;
  }

  @override
  _AreaDialogWidgetState createState() => _AreaDialogWidgetState();
}

class _AreaDialogWidgetState extends State<_AreaDialogWidget> {

  ScrollController _titleListScrollController = ScrollController();
  ScrollController _contentListScrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    _titleListScrollController?.dispose();
    _contentListScrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        //因为用到了垂直方向的ListView，这里需要套个Expanded
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListView.separated(
                      controller: _titleListScrollController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        AreaDialogTitleBean bean = widget.tileList[index];
                        return GestureDetector(
                          child: Center(
                            child: Text(
                              bean.title,
                              style: TextStyle(
                                  color: index == widget.selectIndex
                                      ? AppColors.primary
                                      : AppColors.primary_text,
                                  fontSize: 16),
                            ),
                          ),
                          onTap: () {
                            List<AreaDialogTitleBean> removeList = [];
                            for (int i = widget.tileList.length - 1;
                                i > index;
                                i--) {
                              removeList.add(widget.tileList[i]);
                              widget.childMap.remove(i); //map移除
                            }
                            for (AreaDialogTitleBean titleBean in removeList) {
                              widget.tileList.remove(titleBean);
                            }
                            widget.selectIndex = index;
                            if (!widget.childMap
                                .containsKey(widget.selectIndex)) {
                              AddressAreaParams tempAddressAreaParams =
                                  AddressAreaParams();
                              tempAddressAreaParams.areaCode =
                                  bean.addressAreaBean?.id ?? "";
                              PersonNetUtils.getAreaList(tempAddressAreaParams)
                                  .then((value) {
                                widget.childMap[widget.selectIndex] = value;
                                setState(() {});
                              }).catchError((onError) {
                                ToastUtils.show(onError.toString());
                              });
                            }
                            bean.title = "请选择";
                            bean.addressAreaBean = null;
                            setState(() {});
                          },
                        );
                      },
                      itemCount: widget.tileList.length, separatorBuilder: (BuildContext context, int index) {
                        return Container(width: 10);
                    },
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.close,
                        color: AppColors.secondary_text,
                      ),
                    ),
                    onTap: () {
                      if (widget.onCloseClick != null) {
                        widget.onCloseClick();
                      }
                    },
                  )
                ],
              ),
            ),
            Container(
              color: AppColors.fff0f0f0,
              height: 0.5,
            ),
            Expanded(
              child: ListView.separated(
                controller: _contentListScrollController,
                padding: EdgeInsets.symmetric(vertical: 10),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  AddressAreaBean bean =
                      widget.childMap[widget.selectIndex][index];
                  return GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        bean.name,
                        style: TextStyle(
                            color: AppColors.primary_text, fontSize: 15),
                      ),
                    ),
                    onTap: () {
                      PersonNetUtils.getAreaList(
                              AddressAreaParams()..areaCode = bean.id)
                          .then((value) {
                        if (value == null || value.isEmpty) {
                          if (widget.onSelect != null) {
                            String title = "";
                            int i = 0;
                            for (AreaDialogTitleBean temp in widget.tileList) {
                              if (i < widget.tileList.length - 1) {
                                title += temp.title;
                              }
                              i++;
                            }
                            title += bean.name;
                            widget.onSelect(AreaDialogTitleBean()
                              ..title = title
                              ..addressAreaBean = bean);
                          }

                          return;
                        }
                        widget.tileList[widget.selectIndex].title = bean.name;
                        widget.tileList[widget.selectIndex].addressAreaBean =
                            bean;
                        widget.tileList
                            .add(AreaDialogTitleBean()..title = "请选择");
                        widget.selectIndex++;
                        widget.childMap[widget.selectIndex] = value;
                        setState(() {});
                      }).catchError((onError, stackTrace) {
                        print(stackTrace.toString());
                        ToastUtils.show(onError.toString());
                      });
                    },
                  );
                },
                itemCount: widget.childMap[widget.selectIndex]?.length ?? 0,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 10,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
