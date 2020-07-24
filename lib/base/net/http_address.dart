
import 'package:happy_go_go_flutter/base/config/config.dart';

///url地址
class HttpAddress {
  static final String urlGetPageContentInfo= AppConfig.DOMAIN + "/api/home/v1/pageContentInfo"; //获取首页顶部信息列表
  static final String urlGetPageListInfo = AppConfig.DOMAIN + "/api/home/v1/pageListInfo"; //获取首页商品列表
  static final String urlGetCategoryList = AppConfig.DOMAIN + "/api/home/v1/getCategoryList"; //查询商品分类，分页查询

  static final String urlLogin = AppConfig.DOMAIN + "/api/user/v1/login"; //登录
  static final String urlRegister = AppConfig.DOMAIN + "/api/user/v1/register"; //注册

  static final String urlGetProductDetail = AppConfig.DOMAIN + "/api/product/v1/getProductDetail"; // 获取商品详情信息
}