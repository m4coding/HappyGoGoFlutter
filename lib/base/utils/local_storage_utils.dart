import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences 本地存储
///android 的存储路径为FlutterSharedPreference.xml
///实际对应的key会在前面添加前缀flutter.
class LocalStorageUtils {

  static save(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  static remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
