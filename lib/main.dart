import 'package:flutter/material.dart';
import 'package:flutter_trip/flare_demo/flare_sign_in_demo.dart';
import 'package:flutter_trip/home_pages/home_page.dart';
import 'package:flutter_trip/home_pages/my_page.dart';
import 'package:flutter_trip/home_pages/network_request_test.dart';
import 'package:flutter_trip/home_pages/searchPage.dart';
import 'package:flutter_trip/home_pages/trip_page.dart';
import 'package:flutter_trip/snowflake_landing_page.dart';

void main() {
  runApp(MaterialApp(
    //取消debug标志
    debugShowCheckedModeBanner: false,
    //气泡动画
    home: Snowflake_landing_Page(),

    //小熊动画
    // home: FlareDemo(),
  ));
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MainPage(),
      ),
    );
  }
}


/**
 * 主页面
 */
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;//记录当前按钮位置
  PageController _pageController;//PageView控制器

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: PageView(
            children: [
              HomePage(),
              SearchPage(),
              TripPage(),
              MyPage(),
              NetworkRequestTest(),
            ],
            //当打开页面显示第0个位置
            controller: _pageController = new PageController(initialPage: 0),
            onPageChanged: (index) {
              setState(() {
                //滑动Page使按钮跟随变化
                _currentIndex = index;
              });
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            //点击按钮使用PageView控制器控制当前页面
            _pageController.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          //将文本展示出来
          type: BottomNavigationBarType.fixed,
          items: [
            /**
             * 首页
             */
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页",
              //选中样式
              activeIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            /**
             * 搜索
             */
            BottomNavigationBarItem(

              icon: Icon(Icons.search),
              label: "搜索",
              activeIcon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
            /**
             * 旅拍
             */
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: "旅拍",
              activeIcon: Icon(
                Icons.camera_alt,
                color: Colors.blue,
              ),
            ),
            /**
             * 我的
             */
            BottomNavigationBarItem(
              icon: Icon(Icons.android),
              label: "我的",
              activeIcon: Icon(
                Icons.android,
                color: Colors.blue,
              ),
            ),
            /**
             * test测试
             */
            BottomNavigationBarItem(
              icon: Icon(Icons.text_fields_sharp),
              label: "测试",
              activeIcon: Icon(
                Icons.text_fields_sharp,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
