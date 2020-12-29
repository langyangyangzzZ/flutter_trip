import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/util/toast.dart';

/*
 * @ClassName sq_flie_text
 * 作者: szj
 * 时间: 2020/12/29 11:39
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */

class FloatButtonWidget extends StatefulWidget {
  @override
  _FloatButtonWidgetState createState() => _FloatButtonWidgetState();
}

class _FloatButtonWidgetState extends State<FloatButtonWidget> {
  int _index = 0;

  PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //初始化PageView控制器
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: initPageView(),
      ),

      //初始化floatingActionButton
      floatingActionButton: initFloatingActionButton(),

      //Float位于导航栏之间
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //初始化底部Button按钮
      bottomNavigationBar: initBottomNavigationBar(),
    );
  }

  BottomNavigationBar initBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      //Button按钮跟随滑动
      currentIndex: _index,
      onTap: (index) {
        setState(() {
          _index = index;
        });
        _pageController.jumpToPage(_index);
      },
      items: [
        initBottomNavigationBarItem("11", Icons.colorize, _index == 0),
        initBottomNavigationBarItem("22", Icons.cancel, _index == 1),
        initBottomNavigationBarItem("", Icons.cancel, _index == 2),
        initBottomNavigationBarItem("33", Icons.android, _index == 3),
        initBottomNavigationBarItem("43", Icons.ios_share, _index == 4),
      ],
    );
  }

  Container initFloatingActionButton() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(40)),
      child: FloatingActionButton(
        backgroundColor: _index == 2 ? Colors.yellow : Colors.grey,
        elevation: 10,
        onPressed: () {
          setState(() {
            _index = 2;
            _pageController.jumpToPage(_index);
          });
        },
        child: Icon(Icons.android),
      ),
    );
  }

  /*
   * PageView页面
   */
  PageView initPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _index = index;
        });
      },
      children: [
        initPageViewItem("11"),
        initPageViewItem("22"),
        initPageViewItem("33"),
        initPageViewItem("44"),
        initPageViewItem("55"),
      ],
    );
  }

  /// [s] 当前标题
  /// [icon] 当前图片
  /// [isCheck] 是否选中
  initBottomNavigationBarItem(String s, IconData icon, bool isSelect) {
    return BottomNavigationBarItem(
      title: Text(
        s,
        style: TextStyle(color: isSelect ? Colors.lightGreen : Colors.grey),
      ),
      icon: Icon(
        icon,
        color: isSelect ? Colors.lightGreen : Colors.grey,
      ),
    );
  }

  initPageViewItem(String s) {
    return Container(
      child: Center(
        child: Text(s),
      ),
    );
  }
}
