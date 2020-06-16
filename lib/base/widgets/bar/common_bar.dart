import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///通用的AppBar
class CommonBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonBar(
      {this.title = '',
        this.showShadow = false,
        this.rightDMActions,
        this.backgroundColor = Colors.white,
        this.mainColor = Colors.black,
        this.titleW,
        this.bottom,
        this.leadingImg = '',
        this.leadingW,
        this.backFunction});

  final String title; //标题
  final bool showShadow; //是否设置阴影
  final List<Widget> rightDMActions; //右边的更多项
  final Color backgroundColor; //背景颜色
  final Color mainColor; //
  final Widget titleW; //标题Widget
  final Widget leadingW;
  final PreferredSizeWidget bottom;
  final String leadingImg;
  final VoidCallback backFunction; //返回方法处理

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));

  Widget leading(BuildContext context) {
    return new InkWell(
      child: new Container(
        width: 15,
        height: 28,
        child: leadingImg != ''
            ? new Image.asset(leadingImg)
            : new Icon(CupertinoIcons.back, color: mainColor),
      ),
      onTap: () {
        if (backFunction != null) {
          backFunction();
        } else {
          if (Navigator.canPop(context)) {
            FocusScope.of(context).requestFocus(new FocusNode());
            Navigator.pop(context);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return showShadow
        ? new Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: new BorderSide(
                  color: Color(0xffd6d6d6), width: showShadow ? 0.5 : 0.0))),
      child: new AppBar(
        title: titleW == null
            ? new Text(
          title,
          style: new TextStyle(
              color: mainColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w500),
        )
            : titleW,
        backgroundColor: backgroundColor,
        elevation: 0.0,
        brightness: Brightness.light,
        leading: leadingW ?? leading(context),
        centerTitle: true,
        actions: rightDMActions ?? [new Center()],
        bottom: bottom != null ? bottom : null,
      ),
    )
        : new AppBar(
      title: titleW == null
          ? new Text(
        title,
        style: new TextStyle(
            color: mainColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w500),
      )
          : titleW,
      backgroundColor: backgroundColor,
      elevation: 0.0,
      brightness: Brightness.light,
      leading: leadingW ?? leading(context),
      centerTitle: true,
      bottom: bottom != null ? bottom : null,
      actions: rightDMActions ?? [new Center()],
    );
  }
}