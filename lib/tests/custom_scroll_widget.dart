import 'dart:math';

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
      body: CustomScrollView(
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
          initSliverPersistentHeader("第一组"),

          //可隐藏掉哦...
          initSliverToBoxAdapter(),

          initSliverPersistentHeader("第二组"),

          initSliverList(),
        ],
      ),
    );
  }

  Widget initSliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Container(
        height: 70,
        child: Center(
          child: Text(
            "可隐藏掉哦..",
            style: TextStyle(
              //背景黄色
                shadows: [Shadow(color: Colors.yellow, offset: Offset(1, 1))]),
          ),
        ),
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
      }, childCount: 5),
    );
  }

  ///SliverList
  Widget initSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return Container(
          height: 100,
          alignment: Alignment.center,
          child: Text(
            "SliverList:$index",
            textAlign: TextAlign.center,
          ),
        );
      }, childCount: 10),
    );
  }

  Widget initSliverAppBar() {
    return SliverAppBar(
      title: Text(
        "flutter",
        style: TextStyle(color: Colors.black),
      ),
      //左侧按钮
      leading: CloseButton(),
      //滑动高度
      expandedHeight: 230.0,
      //当snap = true时 这个参数必须为true!!!
      floating: false,

      //AppBar固定
      pinned: true,

      //AppBar跟随手指滑动而滑动  floating必须为true才可以使用
      snap: false,

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
      }, childCount: 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, //四列
        mainAxisSpacing: 8, //item上下间隔
        crossAxisSpacing: 8, //item左右间隔
      ),
    );
  }

  initSliverPersistentHeader(String title) {
    return SliverPersistentHeader(
        //是否固定头布局 默认false
        pinned: true,
        //是否浮动 默认false
        floating: false,
        delegate: MySliverDelegate(
          //缩小后的布局高度
          minHeight: 40.0,
          //展开后的高度
          maxHeight: 80.0,
          child: Container(
              color: Colors.redAccent,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, shadows: [
                    Shadow(color: Colors.white, offset: Offset(1, 1))
                  ]),
                ),
              )),
        ));
  }
}

class MySliverDelegate extends SliverPersistentHeaderDelegate {
  MySliverDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight; //最小高度
  final double maxHeight; //最大高度
  final Widget child; //子Widget布局

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override //是否需要重建
  bool shouldRebuild(MySliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
