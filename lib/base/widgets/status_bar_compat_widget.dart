import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

import 'package:happy_go_go_flutter/style/app_colors.dart';

class StatusBarCompatWidget extends StatelessWidget {
  final Widget child; //布局
  final Color color; //背景颜色

  StatusBarCompatWidget({@required this.child, this.color = AppColors.primary});

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    double top = math.max(padding.top, EdgeInsets.zero.top); //计算状态栏的高度

    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          width: double.infinity,
          height: top,
          color: color,
        ),
        Expanded(child: child),
      ],
    );
  }
}
