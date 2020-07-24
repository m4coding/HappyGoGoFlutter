

import 'package:happy_go_go_flutter/base/config/config.dart';
import 'package:happy_go_go_flutter/base/event/event_bus.dart';
import 'package:happy_go_go_flutter/base/utils/local_storage_utils.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/component/auth/bean/login_bean.dart';
import 'package:happy_go_go_flutter/component/auth/event/login_event.dart';
import 'package:happy_go_go_flutter/component/auth/net/auth_net_utils.dart';

///登录管理器
class LoginManager {

  static LoginManager _instance;
  bool _isLogin = false;
  String _token;

  LoginManager.private();

  static LoginManager getInstance() {
    if (_instance == null) {
      _instance = new LoginManager.private();
    }

    return _instance;
  }

  ///初始化值，每次登录成功后都需要初始化
  void init(isLogin, token, {userName, userHeadUrl}) {
    _isLogin = isLogin;
    _token = token;
  }

  //清理数据
  void _clear() {
    _isLogin = false;
    LocalStorageUtils.remove(AppConfig.KEY_TOKEN);
  }


  bool isLogin() {
    return _isLogin;
  }

  String getToken() {
    return _token;
  }

  ///退出登录
  void logout() {
    _clear();
  }

  ///登录
  Future<LoginBean> login(LoginParam loginParam) {
    return AuthNetUtils.login(loginParam).then((value) {
      //保存token到本地
      String token = "${value.tokenHead} ${value.token}";
      LocalStorageUtils.save(AppConfig.KEY_TOKEN, token);
      init(true, token);
      eventBus.fire(LoginEvent(LoginEvent.TYPE_LOGIN_SUCCESS));
      ToastUtils.show("登录成功");
      return value;
    }).catchError((onError){
      ToastUtils.show(onError.toString());
    });
  }

}