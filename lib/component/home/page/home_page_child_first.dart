import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/widgets/status_bar_compat_widget.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///首页子tab-首页tab
class HomePageChildFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildFirstState();
  }
}

class _HomePageChildFirstState extends State<HomePageChildFirst> {
  @override
  Widget build(BuildContext context) {
    return new StatusBarCompatWidget(
        child: new Container(
            child: Column(
      children: <Widget>[
        Container(
          color: AppColors.primary,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Row(
            //头部
            children: <Widget>[
              Expanded(
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                color: AppColors.white,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: AppColors.secondary_text,
                      size: 20,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                    Text(
                      "商品名",
                      style: TextStyle(
                          color: AppColors.secondary_text, fontSize: 15),
                    ),
                  ],
                ),
              )),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.scanner,
                    color: AppColors.white,
                    size: 20,
                  ),
                  Text(
                    "扫啊扫",
                    style: TextStyle(color: AppColors.white, fontSize: 12),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              ),
              Column(
                children: <Widget>[
                  Icon(
                    Icons.message,
                    color: AppColors.white,
                    size: 20,
                  ),
                  Text(
                    "消息",
                    style: TextStyle(color: AppColors.white, fontSize: 12),
                  )
                ],
              )
            ],
          ),
        )
      ],
    )));
  }
}
