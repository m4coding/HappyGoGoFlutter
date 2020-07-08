

import 'package:happy_go_go_flutter/base/config/config.dart';
import 'package:happy_go_go_flutter/base/utils/local_storage_utils.dart';

///登录管理器
class LoginManager {

  static LoginManager _instance;
  bool _isLogin = false;
  int _userId;
  String _userName;
  String _token;
  String _userHeadUrl;

  LoginManager.private();

  static LoginManager getInstance() {
    if (_instance == null) {
      _instance = new LoginManager.private();
    }

    return _instance;
  }

  ///初始化值，每次登录成功后都需要初始化
  void init(isLogin, token, userId, {userName, userHeadUrl}) {
    _isLogin = isLogin;
    _token = token;
    _userId = userId;
    _userName = userName;
    _userHeadUrl = userHeadUrl;
  }

  ///清理数据
  void clear() {
    _isLogin = false;
    _userId = null;
    _userName = null;
  }

  ///清除本地数据
  void clearLocal() {
    LocalStorageUtils.remove(AppConfig.KEY_TOKEN);
    LocalStorageUtils.remove(AppConfig.KEY_USER_ID);
  }

  bool isLogin() {
    return _isLogin;
  }

  String getToken() {
    return _token;
  }

  int getUserId() {
    return _userId;
  }

  String getUsername() {
    return _userName;
  }

  String getUserHeadUrl() {
    return _userHeadUrl;
  }

  void setUserHeadUrl(String headUrl) {
    this._userHeadUrl = headUrl;
  }

  ///退出登录
  void logout() {
    clear();
    clearLocal();
  }

}