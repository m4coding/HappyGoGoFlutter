import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///商品详情页顶部Bar
class ProductDetailTopBar extends StatefulWidget {

  final double barHeight;
  final void Function(ProductTopType productTopType) onSelectTopType;

  ProductDetailTopBar({Key key, @required this.barHeight, @required this.onSelectTopType}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailTopBarState();
  }
}

class ProductDetailTopBarState extends State<ProductDetailTopBar> {

  ProductTopType _currentProductTopType = ProductTopType.PRODUCT;
  double _barAlpha = 0;

  @override
  void initState() {
    super.initState();
  }

  void onScrollProgress(ScrollNotification notification) {
    _barAlpha = (notification.metrics.pixels / (widget.barHeight * 2))
        .clamp(0, 1.0)
        .toDouble();
    if (_barAlpha <= 1.0) {
      setState(() {});
    }
  }

  void selectTopType(ProductTopType productTopType) {
    if (_currentProductTopType != productTopType) {
      _currentProductTopType = productTopType;
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.barHeight,
      child: Stack(
        children: <Widget>[
          Opacity(
            opacity: _barAlpha,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment(-0.9, 0),
                    child: leading(context),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        getTypeView(context, ProductTopType.PRODUCT),
                        Padding(
                          padding: EdgeInsets.only(left: 12),
                        ),
                        getTypeView(context, ProductTopType.RECOMMEND),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: 1 - _barAlpha,
            child: Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment(-0.9, 0),
                    child: leadingInBg(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTypeView(BuildContext context, ProductTopType productTopType) {
    String text;
    Color textColor;
    FontWeight fontWeight;
    Widget intervalWidget;
    switch (productTopType) {
      case ProductTopType.PRODUCT:
        text = S.of(context).product;
        fontWeight = _currentProductTopType == ProductTopType.PRODUCT
            ? FontWeight.bold
            : FontWeight.normal;
        textColor = _currentProductTopType == ProductTopType.PRODUCT
            ? AppColors.primary_text
            : AppColors.secondary_text;
        intervalWidget = _currentProductTopType == ProductTopType.PRODUCT
            ? Container(
                height: 3,
                width: 20,
                color: AppColors.primary,
                margin: EdgeInsets.only(top: 2),
              )
            : Container(
                height: 3,
                width: 20,
              );
        break;
      case ProductTopType.RECOMMEND:
        text = S.of(context).recommend;
        fontWeight = _currentProductTopType == ProductTopType.RECOMMEND
            ? FontWeight.bold
            : FontWeight.normal;
        textColor = _currentProductTopType == ProductTopType.RECOMMEND
            ? AppColors.primary_text
            : AppColors.secondary_text;
        intervalWidget = _currentProductTopType == ProductTopType.RECOMMEND
            ? Container(
                height: 3,
                width: 20,
                color: AppColors.primary,
                margin: EdgeInsets.only(top: 2),
              )
            : Container(
                height: 3,
                width: 20,
              );
        break;
      default:
        intervalWidget = Container(
          height: 3,
          width: 20,
        );
        break;
    }

    return GestureDetector(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                color: textColor, fontSize: 17, fontWeight: fontWeight),
          ),
          intervalWidget,
        ],
      ),
      onTap: () {
        setState(() {
          _currentProductTopType = productTopType;
          if (widget.onSelectTopType != null) {
            widget.onSelectTopType(_currentProductTopType);
          }
        });
      },
    );
  }

  Widget leading(BuildContext context) {
    return new InkWell(
      child: new Container(
        decoration:
            BoxDecoration(color: Colors.transparent, shape: BoxShape.circle),
        padding: EdgeInsets.all(5),
        child: Container(
            child: new Icon(CupertinoIcons.back, color: Colors.black)),
      ),
      onTap: () {
        if (Navigator.canPop(context)) {
          FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.pop(context);
        }
      },
    );
  }

  Widget leadingInBg(BuildContext context) {
    return new InkWell(
      child: new Container(
        decoration:
            BoxDecoration(color: Colors.black45, shape: BoxShape.circle),
        padding: EdgeInsets.all(5),
        child: Container(
            child: new Icon(CupertinoIcons.back, color: Colors.white)),
      ),
      onTap: () {
        if (Navigator.canPop(context)) {
          FocusScope.of(context).requestFocus(new FocusNode());
          Navigator.pop(context);
        }
      },
    );
  }
}

///顶部导航栏选中的type类型
enum ProductTopType {
  PRODUCT,
  RECOMMEND,
}
