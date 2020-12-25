import 'dart:async';

import 'package:custom_refresh_plugin/custom_refresh_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/util/toast.dart';

/*
 * @ClassName custom_scroll_widget
 * 作者: szj
 * 时间: 2020/12/23 9:41
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class CustomScrollWidget2 extends StatefulWidget {
  @override
  _CustomScrollWidget2State createState() => _CustomScrollWidget2State();
}

class _CustomScrollWidget2State extends State<CustomScrollWidget2>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  PageController _pageController;

  // ignore: non_constant_identifier_names

  Timer _timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Tab控制器
    initTabController();

    ///Page控制器
    initPageController();

    //初始化Timer
    initTimer();


  }

  void initTabController() {
    _tabController = new TabController(
      vsync: this,
      length: 2,
    );
  }

  PageController initPageController() {
    return _pageController = PageController(
        viewportFraction: 0.9, //设置每一个Page不占满屏幕,漏出上一个和下一个Page!
        initialPage: _index, //设置默认Page
        keepPage: true //是否保存当前滚动page
        );
  }

  void initTimer() {
    _timer = new Timer.periodic(new Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _index++;
          if (_index == 4) {
            _index = 0;
          }
          //设置PageView滑动到的页面
          _pageController.animateToPage(_index,
              duration: Duration(seconds: 2), curve: Curves.ease);
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        //下拉刷新回调方法
        onRefresh: initRefresh,
        //可滚动组件在滚动时会发送ScrollNotification类型的通知
        notificationPredicate: (ScrollNotification notifation) {
          //该属性包含当前ViewPort及滚动位置等信息
          ScrollMetrics scrollMetrics = notifation.metrics;
          if (scrollMetrics.minScrollExtent == 0) {
            return true;
          } else {
            return false;
          }
        },
        //NestedScrollView(
        child: initNestedScrollView(),
      ),
    );
  }

  initRefresh() async {
    //模拟网络刷新 等待2秒
    await Future.delayed(Duration(milliseconds: 2000)).then((value) {
      Toast.toast(context, msg: "已刷新");
    });
    //返回值以结束刷新
    return Future.value(true);
  }

  NestedScrollView initNestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          ///初始化SliverAppBar
          initSliverAppBar(),
        ];
      },
      //初始化TabBar
      body: _initTabBarView(),
    );
  }

  bool isCheck = false;

  ///SliverAppBar
  Widget initSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 280,
      //当snap = true时 这个参数必须为true!!!
      floating: false,

      //AppBar固定
      pinned: true,

      //AppBar跟随手指滑动而滑动  floating必须为true才可以使用
      snap: false,

      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: initPageView(),
      ),

      //搜索按钮
      title: initsearch(),
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 44),
        //初始化initTabBar
        child: initTabBar(),
      ),
    );
  }

  TabBar initTabBar() {
    return TabBar(
      controller: _tabController,

      //Tab控制条颜色
      indicatorColor: Colors.blue,

      //字体颜色
      labelColor: Colors.black,

      //Tab粗细
      indicatorWeight: 3,

      //设置Tab字体与控制器一样大
      indicatorSize: TabBarIndicatorSize.label,

      //Tab是否平分
      isScrollable: false,

      tabs: [
        Tab(
          child: Text(
            "数学",
          ),
        ),
        Tab(
          child: Text(
            "英语",
          ),
        ),
      ],
    );
  }

  InkWell initsearch() {
    return InkWell(
      onTap: () {
        Toast.toast(context, msg: "点击了搜索");
      },
      child: Container(
        height: 38,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Text(
          "搜索",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }

  ///TabBar
  Widget _initTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        initListView("数学"),
        initListView("英语"),
      ],
    );
  }
  //默认从0的位置开始
  int _index = 0;

  //初始化PageView
  Widget initPageView() {
    return Stack(
      children: [
        //PageView
        buildPageView(),

        //滑动圆点
        buildRound(),
      ],
    );
  }

  //滑动圆点
  Positioned buildRound() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          initRound(_index == 0),
          initRound(_index == 1),
          initRound(_index == 2),
          initRound(_index == 3),
        ],
      ),
    );
  }

  //创建PageView
  Widget buildPageView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: PageView(
        controller: _pageController,
        children: [
          initPageItem(Colors.deepPurple, "Page1"),
          initPageItem(Colors.deepOrange, "Page2"),
          initPageItem(Colors.yellow, "Page3"),
          initPageItem(Colors.lightGreenAccent, "Page4"),
        ],
        onPageChanged: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
    );
  }

  Widget initPageItem(Color color, String title) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: Text(title),
    );
  }

  //初始化圆
  Widget initRound(bool isselect) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      width: isselect ? 30 : 10,
      height: 10,
      margin: EdgeInsets.only(left: 5, right: 5),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        color: isselect ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  //初始化ListView
  initListView(String s) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          alignment: Alignment.center,
          child: Text("$s$index"),
        );
      },
      itemCount: 30,
    );
  }
}
