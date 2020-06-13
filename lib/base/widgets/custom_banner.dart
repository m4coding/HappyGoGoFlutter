import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomBanner<T> extends StatefulWidget {
  final List<T> list;
  final double height;
  final String Function(int index) onGetImageUrl;
  final Function(int index) onItemClick;

  CustomBanner(this.list, this.height, this.onGetImageUrl, {this.onItemClick});

  @override
  _BannerState createState() =>
      _BannerState<T>(this.list, this.height, this.onGetImageUrl, this.onItemClick);
}

List<T> _map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class _BannerState<T> extends State<CustomBanner> {
  int _current = 0;
  List<T> _list;
  double _height;
  String Function(int index) _onGetImageUrl;
  Function(int index) _onItemClick;

  _BannerState(this._list, this._height, this._onGetImageUrl,this._onItemClick);

  String _getImageUrl(int index) {
    if (_onGetImageUrl != null) {
      return _onGetImageUrl(index);
    }
    return "";
  }

  _itemClick(int index) {
    if (_onItemClick != null) {
      _onItemClick(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      CarouselSlider(
        height: _height,
        items: _map<Widget>(
          _list,
          (index, i) {
            return GestureDetector(onTap: ()=>_itemClick(index), child: Container(
              width: MediaQuery.of(context).size.width,
              child: Image.network(_getImageUrl(index), fit: BoxFit.cover),
            ),);
          },
        ).toList(),
        autoPlayInterval: const Duration(seconds: 6),
        autoPlay: true,
        viewportFraction: 1.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Positioned(
        bottom: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _map<Widget>(
            _list,
            (index, url) {
              return Container(
                width: 7.0,
                height: 7.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(255, 255, 255, 1.0)
                        : Color.fromRGBO(255, 255, 255, 0.5)),
              );
            },
          ),
        ),
      ),
    ]);
  }
}
