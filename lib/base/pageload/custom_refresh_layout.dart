import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///下拉刷新，加载更多自定制layout
class CustomRefreshLayout extends StatefulWidget {
  final RefreshController controller;
  final Widget child;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;

  CustomRefreshLayout(
      {@required this.controller, this.child, this.onRefresh, this.onLoading});

  @override
  State<StatefulWidget> createState() {
    return _CustomRefreshLayoutState();
  }
}

class _CustomRefreshLayoutState extends State<CustomRefreshLayout> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.controller,
      enablePullDown: true,
      enablePullUp: true,
      child: widget.child,
      onLoading: widget.onLoading,
      onRefresh: widget.onRefresh,
      header: _getHeader(),
      footer: _getFooter(),
    );
  }

  Widget _getHeader() {
    return ClassicHeader(
      releaseText: "释放刷新",
      refreshingText: "正在刷新",
      completeText: "刷新完成",
      failedText: "刷新失败",
      idleText: "下拉刷新",);
  }

  Widget _getFooter() {
    return CustomFooter(
      builder: (BuildContext context, LoadStatus mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = Text("");
        } else if (mode == LoadStatus.loading) {
          body = CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = Text("加载失败，点击重试");
        } else if (mode == LoadStatus.canLoading) {
          body = Text("");
        } else {
          body = Text("没有更多数据了");
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
