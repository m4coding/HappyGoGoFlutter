import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/base/utils/toast_utils.dart';
import 'package:happy_go_go_flutter/component/person/bean/user_info_bean.dart';
import 'package:happy_go_go_flutter/component/person/net/person_net_utils.dart';
import 'package:happy_go_go_flutter/style/app_colors.dart';

///首页子tab-个人中心tab
class HomePageChildPerson extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildPersonState();
  }
}

class _HomePageChildPersonState extends State<HomePageChildPerson>
    with AutomaticKeepAliveClientMixin {
  UserInfoBean _userInfoBean;

  @override
  void initState() {
    super.initState();

    _getNetData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: AppColors.fff0f0f0,
      child: CustomScrollView(
        slivers: <Widget>[
          _getHeader(),
          _getOrderLayout(),
          _getRecommendLayout(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  //头部
  Widget _getHeader() {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, right: 20, left: 20),
        height: 165,
        color: AppColors.primary,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: <Widget>[
                        ClipOval(
                          child: CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl: _userInfoBean?.headUrl ?? "",
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) => Container(
                              width: 50,
                              height: 50,
                              color: AppColors.fff5f5f5,
                            ),
                            placeholder: (context, url) => Container(
                              width: 50,
                              height: 50,
                              color: AppColors.fff5f5f5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                        ),
                        Text(
                          _userInfoBean?.userName ?? "--",
                          style:
                              TextStyle(color: AppColors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "--",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          ),
                          Text(
                            "商品关注",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "--",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          ),
                          Text(
                            "店铺关注",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "--",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          ),
                          Text(
                            "优惠券",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          )
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "--",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          ),
                          Text(
                            "浏览记录",
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
              right: 0,
              child: GestureDetector(
                child: Icon(
                  Icons.settings,
                  color: AppColors.white,
                  size: 20,
                ),
                onTap: () => _goToSetting,
              ),
            )
          ],
        ),
      ),
    );
  }

  //订单layout
  Widget _getOrderLayout() {
    return SliverToBoxAdapter(
      child: Container(),
    );
  }

  //为你推荐layout
  Widget _getRecommendLayout() {
    return SliverToBoxAdapter(
      child: Container(),
    );
  }

  //todo 设置页面
  void _goToSetting() {

  }

  void _getNetData() {
    PersonNetUtils.getUserInfo().then((value) {
      setState(() {
        _userInfoBean = value;
      });
    }).catchError((error) {
      ToastUtils.show(error.toString());
    });
  }
}
