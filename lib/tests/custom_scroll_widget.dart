import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/util/toast.dart';

/*
 * @ClassName custom_scroll_widget
 * 作者: szj
 * 时间: 2020/12/23 9:41
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class CustomScrollWidget extends StatefulWidget {
  @override
  _CustomScrollWidgetState createState() => _CustomScrollWidgetState();
}

class _CustomScrollWidgetState extends State<CustomScrollWidget> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  CustomScrollView(
//      滑动类型
//      BouncingScrollPhysics() 拉到最底部有回弹效果
//    ClampingScrollPhysics() 包裹内容不会回弹
//    NeverScrollableScrollPhysics() 滑动禁止
        physics: BouncingScrollPhysics(),
        //true反向滑动AppBar
        shrinkWrap: false,

        // 当条目不足时 true可以尝试滚动 false不可以滚动
        primary: true,
          //缓存条目
        cacheExtent: 0,
        //滚动方向
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          initSliverAppBar(),
          initSliverFixedExtentList(),
          initSliverList(),
          initSliverGrid(),
        ],
      ),
    );
  }

  /// appbar 右侧图片
  List<Widget> initAppBarRightIcon() {
    List<Widget> list = [];

    list.add(
      new IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Toast.toast(context, msg: "添加");
        },
      ),
    );

    list.add(
      new IconButton(
        icon: Icon(Icons.more_horiz),
        onPressed: () {
          Toast.toast(context, msg: "更多");
        },
      ),
    );

    return list;
  }

  ///SliverFixedExtentList
  Widget initSliverFixedExtentList() {
    return SliverFixedExtentList(
      //设置子条目高度
      itemExtent: 70.0,
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Text('SliverFixedExtentList$index ');
      }, childCount: 10),
    );
  }

  ///SliverList
  Widget initSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Text(
          "SliverList:$index",
          textAlign: TextAlign.center,
        );
      }, childCount: 10),
    );
  }

  Widget initSliverAppBar() {
    return  SliverAppBar(
      title: Text(
        "flutter",
        style: TextStyle(color: Colors.black),
      ),
      //左侧按钮
      leading: CloseButton(),
      //滑动高度
      expandedHeight: 230.0,
      //当snap = true时 这个参数必须为true!!!
      floating: true,

      //AppBar固定
      pinned: true,

      //AppBar跟随手指滑动而滑动  floating必须为true才可以使用
      snap: true,

      //滑动背景
      flexibleSpace: new FlexibleSpaceBar(
        background: Image.asset(
          "assets/images/flutter.jpg",
          fit: BoxFit.fill,
        ),
        // titlePadding: EdgeInsets.only(left: 60),
        title: new Text(
          "android",
          style: TextStyle(color: Colors.black),
        ),
        //标题居中
        centerTitle: true,
        //滑动模式  CollapseMode.parallax,
        //          CollapseMode.none,
        collapseMode: CollapseMode.pin,
      ),

      //背景颜色
      backgroundColor: Colors.blue,

      //状态栏主题 Brightness.light灰色 Brightness.dark白色(默认)
      brightness: Brightness.dark,

      //AppBar是否在状态栏下面
      primary: true,

      //标题(title)是否居中
      centerTitle: false,
      // bottom: PreferredSizeWidget(),
      //右侧Widget操作
      actions: initAppBarRightIcon(),
    );
  }

  Widget initSliverGrid() {
    return SliverGrid(
      //子Widget布局
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Text("SliverGrid:$index");
      }, childCount: 20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, //四列
        mainAxisSpacing: 8, //item上下间隔
        crossAxisSpacing: 8, //item左右间隔
      ),
    );
  }
}
