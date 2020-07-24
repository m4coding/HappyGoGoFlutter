import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_go_go_flutter/generated/l10n.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///下拉刷新，加载更多自定制layout
class CustomRefreshLayout extends StatefulWidget {
  final RefreshController controller;
  final Widget child;
  final VoidCallback onRefresh;
  final VoidCallback onLoading;
  final bool enablePullDown; //是否使能下拉刷新
  final bool enablePullUp; //是否使能上拉加载更多

  CustomRefreshLayout(
      {@required this.controller, this.child, this.onRefresh, this.onLoading, this.enablePullUp, this.enablePullDown});

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
      enablePullDown: widget.enablePullDown ?? true,
      enablePullUp: widget.enablePullUp ?? true,
      child: widget.child,
      onLoading: widget.onLoading,
      onRefresh: widget.onRefresh,
      header: _getHeader(),
      footer: _getFooter(),
    );
  }

  Widget _getHeader() {
    return ClassicHeader(
      releaseText: S.of(context).release_the_refresh,
      refreshingText: S.of(context).is_pull_refreshing,
      completeText: S.of(context).fresh_end,
      failedText: S.of(context).fresh_fail,
      idleText: S.of(context).pull_to_fresh,);
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
          body = Text(S.of(context).more_load_error);
        } else if (mode == LoadStatus.canLoading) {
          body = Text("");
        } else {
          body = Text(S.of(context).more_load_end);
        }
        return Container(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
