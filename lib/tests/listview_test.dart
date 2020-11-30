import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListView_Test extends StatefulWidget {
  @override
  _ListView_TestState createState() => _ListView_TestState();
}

class _ListView_TestState extends State<ListView_Test> {
  List _mListCity = [
    "北京市",
    "山西省",
    "山东省",
    "太原市",
    "西安市",
    "广州市",
    "上海市",
    "深圳市",
    "西藏",
    "安阳市",
    "郑州市",
    "南阳市",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ListView"),
        ),
        body: RefreshIndicator(
            onRefresh: initRefresh,
            child: Container(
              child: ListView(
                //滑动方向
                scrollDirection: Axis.vertical,
                //子Widget
                children: initItem(),
                //反转 最好是占盘全屏使用
                reverse: true,
                shrinkWrap: true,
                //垂直时显示的子Widget高度 水平时显示的子Widget宽度
                itemExtent: 100,
                //ListView边距
                padding: EdgeInsets.all(20),
              ),

            )));
  }

  List<Widget> initItem() {
    return _mListCity.map((e) {
      print("_mListCity${e}");
      return Container(
        color: Colors.black38,
        width: 100,
        alignment: Alignment.center,
        child: Text(e),
      );
    }).toList();
  }

  Future<Null> initRefresh() async {
    await Future.delayed(new Duration(seconds: 1)).whenComplete(() {
      setState(() {
        _mListCity.setAll(0, _mListCity.reversed.toList());
      });
    });

    return null;
  }
}
