import 'package:fluttertoast/fluttertoast.dart';

///Toast工具类
class ToastUtils {
  static show(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static cancel() {
    Fluttertoast.cancel();
  }
}