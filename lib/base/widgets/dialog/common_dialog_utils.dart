
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/widgets/dialog/h_dialog.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///通用弹窗工具类
class CommonDialogUtils {

  static HDialog showCommonDialog(
      String content, String textLeft, VoidCallback leftOnTap, String textRight,
      VoidCallback rightOnTap, {canTouchDismiss = true, canBackDismissible = true}) {
    return HDialog().build()
      ..barrierDismissible = canTouchDismiss
      ..canBackDismissible = canBackDismissible
      ..width = 280
      ..borderRadius = 4.0
      ..text(
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        textAlign: TextAlign.center,
        text: content,
        color: Color(0xff333333),
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
      ..divider()
      ..doubleButton(
        gravity: Gravity.center,
        withDivider: true,
        text1: textLeft,
        color1: AppColors.ff999999,
        fontSize1: 14.0,
        fontWeight1: FontWeight.bold,
        onTap1: leftOnTap,
        text2: textRight,
        color2: AppColors.accent,
        fontSize2: 14.0,
        fontWeight2: FontWeight.bold,
        onTap2: rightOnTap,
      )
      ..show();
  }
}
