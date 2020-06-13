import 'package:flutter/material.dart';

//四种视图状态
enum LoadLayoutState { State_Success, State_Error, State_Loading, State_Empty }

///根据不同状态来展示不同的视图
class LoadStateLayout extends StatefulWidget {
  final LoadLayoutState state; //页面状态
  final Widget successWidget; //成功视图
  final VoidCallback errorRetry; //错误事件处理
  final VoidCallback emptyRetry; //空数据事件处理

  LoadStateLayout(
      {Key key,
      this.state = LoadLayoutState.State_Loading, //默认为加载状态
      this.successWidget,
      this.errorRetry,
      this.emptyRetry})
      : super(key: key);

  @override
  _LoadStateLayoutState createState() => _LoadStateLayoutState();
}

class _LoadStateLayoutState extends State<LoadStateLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //宽高都充满屏幕剩余空间
      width: double.infinity,
      height: double.infinity,
      child: _buildWidget,
    );
  }

  ///根据不同状态来显示不同的视图
  Widget get _buildWidget {
    switch (widget.state) {
      case LoadLayoutState.State_Success:
        return widget.successWidget;
        break;
      case LoadLayoutState.State_Error:
        return _errorView;
        break;
      case LoadLayoutState.State_Loading:
        return _loadingView;
        break;
      case LoadLayoutState.State_Empty:
        return _emptyView;
        break;
      default:
        return null;
    }
  }

  ///加载中视图
  Widget get _loadingView {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      color: Colors.white,
      child: Container(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          strokeWidth: 4,
        ),
      ),
    );
  }

  ///错误视图
  Widget get _errorView {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: GestureDetector(
          onTap: widget.errorRetry,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "加载失败，请点击重试!",
                style: TextStyle(color: Color(0xff999999), fontSize: 18),
              ),
            ],
          ),
        ));
  }

  Widget get _emptyView {
    return Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '暂无数据',
              style: TextStyle(color: Color(0xff999999), fontSize: 18),
            )
          ],
        ));
  }
}
