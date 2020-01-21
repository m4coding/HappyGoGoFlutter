import 'package:flutter/cupertino.dart';

///首页子tab-分类页
class HomePageChildCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageChildCategoryState();
  }

}

class _HomePageChildCategoryState extends State<HomePageChildCategory> {
  @override
  Widget build(BuildContext context) {
    return new Container(child: Text("Category"),);
  }
}