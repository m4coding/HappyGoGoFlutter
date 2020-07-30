import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/dialog/h_dialog.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///购物车加购view
class AddCartCountView extends StatefulWidget {


  final int step; //步进值
  final int minCount; //最低起购量
  final int stock; //商品库存量
  final int quantity; //数量
  TextEditingController editController = new TextEditingController();
  final void Function(int quantity) onChangeCount;
  final void Function() onEditTap;

  AddCartCountView({Key key, this.step = 1, this.minCount = 1, @required this.stock, this.quantity, this.onChangeCount, this.onEditTap}) : super(key: key) {
    if (quantity != null) {
      editController.text = quantity.toString();
    } else {
      editController.text = minCount.toString();
    }
  }

  @override
  State<StatefulWidget> createState() {
    return AddCartCountViewState();
  }
}

class AddCartCountViewState extends State<AddCartCountView> with WidgetsBindingObserver {

  static const int MAX_NUM = 999;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focusNode = FocusNode();

  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    WidgetsBinding.instance.addPostFrameCallback((_) {
//      logger.d("AddCartCountViewState", "bottom=${MediaQuery.of(HDialog.getContext()).viewInsets.bottom}");
      if (MediaQuery.of(HDialog.getContext()).viewInsets.bottom <= 0) { //监听键盘收起
        _focusNode.unfocus();
      }
    });
  }


  @override
  void dispose() {
    super.dispose();

    _focusNode.dispose();
    widget.editController?.dispose();
    widget.editController = null;
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 101,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Icon(
                Icons.remove,
                size: 20,
                color: AppColors.primary_text,
              ),
            ),
            onTap: () {
              _focusNode.unfocus();
              int num = int.parse(widget.editController.text) - widget.step;
              if (num <= 0) {
                num = widget.minCount;
                ToastUtils.show("不能低于最小起购量");
              }
              widget.editController.text =
                  (num).toString();

              widget.onChangeCount?.call(num);

              _setSelectionEnd();

              setState(() {

              });
            },
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3),
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(
                    color: AppColors.secondary_text,
                    width: 0.5,
                    style: BorderStyle.solid)),
            child: TextField(
              textInputAction: TextInputAction.done,
              focusNode: _focusNode,
              cursorColor: AppColors.accent,
              textAlign: TextAlign.center,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3) //限制长度
              ],
              keyboardType: TextInputType.number,
              controller: widget.editController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 15, color: AppColors.ff333333),
              onChanged: (value) {
                widget.onChangeCount?.call(int.parse(value));
              },
              onTap: () {
                widget.onEditTap?.call();
              },
            ),
          )),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Icon(
                Icons.add,
                size: 20,
                color: AppColors.primary_text,

              ),
            ),
            onTap: () {
              _focusNode.unfocus();
              int num = int.parse(widget.editController.text) + 1;
              if (num > MAX_NUM) {
                num = MAX_NUM;
                ToastUtils.show("购买量不能超过$MAX_NUM最大限制");
              } else if (num > widget.stock) {
                num = widget.stock;
                ToastUtils.show("购买量不能超过${widget.stock}最大库存量");
              }
              widget.editController.text = num.toString();

              widget.onChangeCount?.call(num);

              _setSelectionEnd();
            },
          ),
        ],
      ),
    );
  }

  //设置输入光标后置
  void _setSelectionEnd() {
    widget.editController.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: '${widget.editController.text}'.length));
  }


  int getQuantity() {
    return int.parse(widget.editController.text);
  }
}


