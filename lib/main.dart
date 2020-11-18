import 'package:flutter/material.dart';
import 'package:flutter_trip/flare_demo/flare_sign_in_demo.dart';
import 'package:flutter_trip/home_pages/home_page.dart';
import 'package:flutter_trip/home_pages/my_page.dart';
import 'package:flutter_trip/home_pages/search_page.dart';
import 'package:flutter_trip/home_pages/trip_page.dart';

void main() {
  runApp(FlareDemo());
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
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页",
              //选中样式
              activeIcon: Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "搜索",
              activeIcon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: "旅拍",
              activeIcon: Icon(
                Icons.camera_alt,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.android),
              label: "我的",
              activeIcon: Icon(
                Icons.android,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
