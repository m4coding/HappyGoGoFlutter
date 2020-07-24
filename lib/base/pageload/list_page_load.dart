import 'package:happy_go_go_flutter/base/utils/log_utils.dart';
import 'package:happy_go_go_flutter/base/widgets/load_state_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///@author mochangsheng
///下拉刷新，分页加载逻辑汇总
abstract class ListPageLoad<B> {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int page = 1;
  int pageSize = 20;
  List<B> dataList = [];
  LoadType loadType = LoadType.LOAD_TYPE_START_LOAD;

  void onRefresh() async {
    loadType = LoadType.LOAD_TYPE_START_PULL_DOWN_LOAD;
    onStartLoad(loadType);
    page = 1;
    getData(page, pageSize).then((value) {
      dataList.clear();
      dataList.addAll(value);
      updateView();
      refreshController.refreshCompleted();
      refreshController.loadComplete();
      loadType = LoadType.LOAD_TYPE_SUCCESS_PULL_DOWN_LOAD;
      onSuccessLoad(loadType);
    }).catchError((onError) {
      logger.d(onError.toString());
      refreshController.refreshFailed();
      refreshController.loadComplete();//重置下加载更多，加载更多逻辑影响
      loadType = LoadType.LOAD_TYPE_ERROR_PULL_DOWN_LOAD;
      onErrorLoad(loadType);
    });
  }

  void onLoadMore() async {
    if (loadType != LoadType.LOAD_TYPE_ERROR_MORE_LOAD) {
      page++;
    }
    loadType = LoadType.LOAD_TYPE_START_MORE_LOAD;
    onStartLoad(loadType);

    getData(page, pageSize).then((value) {
      if (value == null || value.isEmpty) {
        refreshController.loadNoData(); //已加载到没有数据
      } else {
        dataList.addAll(value);
        updateView();
        refreshController.loadComplete();
      }

      loadType = LoadType.LOAD_TYPE_SUCCESS_MORE_LOAD;
      onSuccessLoad(loadType);

    }).catchError((onError) {
      logger.d(onError.toString());
      refreshController.loadFailed();
      loadType = LoadType.LOAD_TYPE_ERROR_MORE_LOAD;
      onErrorLoad(loadType);
    });
  }

  ///刷新
  void load() {
    loadType = LoadType.LOAD_TYPE_START_LOAD;
    onStartLoad(loadType);
    page = 1;
    getData(page, pageSize).then((value) {
      dataList.clear();
      dataList.addAll(value);
      updateView();
      loadType = LoadType.LOAD_TYPE_SUCCESS_LOAD;
      onSuccessLoad(loadType);
    }).catchError((onError) {
      logger.d(onError.toString());
      dataList.clear();
      updateView();
      loadType = LoadType.LOAD_TYPE_ERROR_LOAD;
      onErrorLoad(loadType);
    });
  }

  LoadLayoutState getLoadStateLayoutState() {
    if (loadType == LoadType.LOAD_TYPE_ERROR_LOAD) {
      return LoadLayoutState.State_Error;
    } else if (loadType == LoadType.LOAD_TYPE_START_LOAD) {
      return LoadLayoutState.State_Loading;
    } else {
      if (dataList.isEmpty) {
        return LoadLayoutState.State_Empty;
      }
    }

    return LoadLayoutState.State_Success;
  }

  /// 开始加载
  void onStartLoad(LoadType type) {

  }

  /// 成功加载
  void onSuccessLoad(LoadType type) {}

  /// 错误加载
  void onErrorLoad(LoadType type) {}

  void updateView();

  ///获取列表数据
  Future<List<B>> getData(int page, int pageSize);
}

///加载类型
enum LoadType {
  LOAD_TYPE_START_LOAD, //开始加载
  LOAD_TYPE_START_PULL_DOWN_LOAD, //开始下拉刷新
  LOAD_TYPE_START_MORE_LOAD, //开始上拉加载更多

  LOAD_TYPE_SUCCESS_LOAD, //成功加载完成
  LOAD_TYPE_SUCCESS_PULL_DOWN_LOAD, //成功下拉刷新完成
  LOAD_TYPE_SUCCESS_MORE_LOAD, // 成功上拉加载更多完成

  LOAD_TYPE_ERROR_LOAD, //错误加载
  LOAD_TYPE_ERROR_PULL_DOWN_LOAD, //下拉刷新错误
  LOAD_TYPE_ERROR_MORE_LOAD, //上拉加载错误

  LOAD_TYPE_MORE_LOAD_END, //上拉加载结束，同时没有更多数据了

}
