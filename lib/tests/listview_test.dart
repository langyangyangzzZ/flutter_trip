import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/tests/open_container_text.dart';
import 'package:flutter_trip/util/log_util.dart';

class ListView_Test extends StatefulWidget {
  @override
  _ListView_TestState createState() => _ListView_TestState();
}

class _ListView_TestState extends State<ListView_Test> {
  List _mListCity = [];
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();

    for (int i = 0; i <= 20; i++) {
      _mListCity.add("元素$i");
    }

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        LogUtil.Log(
            tagging: "加载更多",
            title:
                "pixels:${scrollController.position.pixels} maxScrollExtent: ${scrollController.position.maxScrollExtent}");
        setState(() {
          for (int i = 0; i <= 20; i++) {
            _mListCity.add("加载更多元素$i");
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: RefreshIndicator(
        onRefresh: initRefresh,
        child: Container(
          child: GridView(
            //滑动方向
            scrollDirection: Axis.vertical,
            //子Widget
            children: initItem(),

            //反转 最好是占盘全屏使用
            // reverse: true,
            shrinkWrap: true,
            //垂直时显示的子Widget高度 水平时显示的子Widget宽度
            // itemExtent: 100,
            //GridView边距
            padding: EdgeInsets.all(20),
            //单独Item属性 必加
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                //单个子Widget的水平最大宽度
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                //水平单个子Widget之间间距
                mainAxisSpacing: 20.0,
                //垂直单个子Widget之间间距
                crossAxisSpacing: 10.0),
          ),
        ),
      ),
    );
  }

  List<Widget> initItem() {
    return _mListCity.map((e) {
      //animations: ^1.1.2 #Material Design 设计风格中的容器转换过渡
      return OpenContainer(
        //当前控件颜色
        closedColor: Colors.black38,
        //当前页面圆角默认为4.0
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        //当前页面布局
        closedBuilder: (BuildContext context, void Function() action) {
          return Container(
            width: 100,
            alignment: Alignment.center,
            child: Text(e),
          );
        },
        closedElevation: 1,
        //过渡的方式 淡出动画
        transitionType: ContainerTransitionType.fade,

        //跳转的时间
        transitionDuration: new Duration(seconds: 2),
        //要打开页面布局
        openBuilder:
            (BuildContext context, void Function({Object returnValue}) action) {
          return OpenContainerText();
        },
        //要打开页面的颜色
        openColor: Colors.red,
        //要打开页面的圆角
        openShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        //要打开页面阴影
        openElevation: 2.0,
      );
    }).toList();
  }

  Future<Null> initRefresh() async {
    await Future.delayed(new Duration(seconds: 1)).whenComplete(() {
      setState(() {
        for (int i = 0; i <= 10; i++) {
          _mListCity.add("上拉刷新元素$i");
        }
      });
    });

    return null;
  }
}
