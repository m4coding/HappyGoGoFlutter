import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/pageload/list_page_load.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///商品详情页加载尾部
class ProductDetailLoadFooter extends StatefulWidget {

  final VoidCallback onFailRetry;

  ProductDetailLoadFooter({Key key, this.onFailRetry}) : super(key: key);

  @override
  ProductDetailLoadFooterState createState() => ProductDetailLoadFooterState();
}

class ProductDetailLoadFooterState extends State<ProductDetailLoadFooter> {
  LoadType _loadType;

  @override
  Widget build(BuildContext context) {
    Widget child;

    switch (_loadType) {
      case LoadType.LOAD_TYPE_START_LOAD:
      case LoadType.LOAD_TYPE_START_MORE_LOAD:
        child = Center(
            child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ));
        break;
      case LoadType.LOAD_TYPE_ERROR_MORE_LOAD:
      case LoadType.LOAD_TYPE_ERROR_LOAD:
        child = GestureDetector(
          child: Center(
              child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              S.of(context).more_load_error,
              style: TextStyle(color: AppColors.primary_text),
            ),
          )),
          onTap: () {
            if(widget.onFailRetry != null) {
              widget.onFailRetry();
            }
          },
        );
        break;
      case LoadType.LOAD_TYPE_MORE_LOAD_END:
        child = Center(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                S.of(context).more_load_end,
                style: TextStyle(color: AppColors.primary_text),
              ),
            ));
        break;
      default:
        child = Container();
    }

    return SliverToBoxAdapter(
      child: child,
    );
  }

  ///刷新
  void updateStatus(LoadType loadType) {
    setState(() {
      _loadType = loadType;
    });
  }
}
