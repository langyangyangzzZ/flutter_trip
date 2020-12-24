import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  List<String> _tabtitleList = [];

  Timer _timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i <= 1; i++) {
      _tabtitleList.add("标签$i");
    }

    //Tab控制器
    _tabController = new TabController(
      vsync: this,
      length: _tabtitleList.length,
    );

    ///Page控制器
    _pageController = PageController(
        viewportFraction: 0.9, //设置每一个Page不占满屏幕,漏出上一个和下一个Page!
        initialPage: _index, //设置默认Page
        keepPage: true //是否保存当前滚动page
    );


    _timer = new Timer.periodic(new Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _index ++;
          if(_index == 4){
            _index = 0;
          }
          //设置PageView滑动到的页面
          _pageController.animateToPage(_index, duration: Duration(seconds: 2),curve: Curves.ease);
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            initSliverAppBar(),
          ];
        },
        body: _initTabBarView(),
      ),
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

      title: Container(
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
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery
            .of(context)
            .size
            .width, 44),
        child: TabBar(
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
        ),
      ),
    );
  }

  ///TabBar
  Widget _initTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        Center(
          child: Text(
            "数学",
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
        ),
        Center(
          child: Text(
            "英语",
            style: TextStyle(color: Colors.black, fontSize: 40),
          ),
        ),
      ],
    );
  }

  int _index = 0;

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

  Container buildPageView() {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: PageView(
            controller:_pageController,
            children: [
            initPageItem(Colors.deepPurple, "Page1"),
        initPageItem(Colors.deepOrange, "Page2"),
        initPageItem(Colors.yellow, "Page3"),
        initPageItem(Colors.lightGreenAccent, "Page4"),
        ],
        onPageChanged: (index)
    {
      setState(() {
        _index = index;
      });
    },)
    ,
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

  Widget initRound(bool isselect) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      width: isselect ? 30 : 10,
      height: 10,
      margin: EdgeInsets.only(left: 5, right: 5),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
          color: isselect ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20)),
    );
  }
}
