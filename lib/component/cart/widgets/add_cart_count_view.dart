import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///购物车加购view
class AddCartCountView extends StatefulWidget {


  final int step; //步进值
  final int minCount; //最低起购量
  final int stock; //商品库存量

  AddCartCountView({Key key, this.step = 1, this.minCount = 1, @required this.stock}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddCartCountViewState();
  }
}

class AddCartCountViewState extends State<AddCartCountView> {

  static const int MAX_NUM = 999;

  TextEditingController _editController = new TextEditingController();


  @override
  void initState() {
    super.initState();

    _editController.text = widget.minCount.toString();
  }

  @override
  void dispose() {
    super.dispose();

    _editController.dispose();
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
              int num = int.parse(_editController.text) - widget.step;
              if (num <= 0) {
                num = widget.minCount;
                ToastUtils.show("不能低于最小起购量");
              }
              _editController.text =
                  (num).toString();

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
              cursorColor: AppColors.accent,
              textAlign: TextAlign.center,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3) //限制长度
              ],
              keyboardType: TextInputType.number,
              controller: _editController,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: 15, color: AppColors.ff333333),
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

              int num = int.parse(_editController.text) + 1;
              if (num > MAX_NUM) {
                num = MAX_NUM;
                ToastUtils.show("购买量不能超过$MAX_NUM最大限制");
              } else if (num > widget.stock) {
                num = widget.stock;
                ToastUtils.show("购买量不能超过${widget.stock}最大库存量");
              }
              _editController.text = num.toString();

              _setSelectionEnd();
            },
          ),
        ],
      ),
    );
  }

  //设置输入光标后置
  void _setSelectionEnd() {
    _editController.selection = TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: '${_editController.text}'.length));
  }


  int getQuantity() {
    return int.parse(_editController.text);
  }
}
