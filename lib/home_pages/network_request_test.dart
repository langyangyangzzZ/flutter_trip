import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/home_pages/root_page.dart';
import 'package:flutter_trip/logins/video_page_widget.dart';
import 'package:flutter_trip/tests/a_test.dart';
import 'package:flutter_trip/tests/animation_text.dart';
import 'package:flutter_trip/tests/cupertino_picker_text.dart';
import 'package:flutter_trip/tests/custom_scroll_widget.dart';
import 'package:flutter_trip/tests/custom_scroll_widget2.dart';
import 'package:flutter_trip/tests/database_text.dart';
import 'package:flutter_trip/tests/http_test.dart';
import 'package:flutter_trip/tests/gridview_test.dart';
import 'package:flutter_trip/tests/listview_text.dart';
import 'package:flutter_trip/tests/plug_text.dart';
import 'package:flutter_trip/tests/rich_text.dart';
import 'package:flutter_trip/tests/shared_perferences_test.dart';
import 'package:flutter_trip/tests/show_popup_text.dart';
import 'package:flutter_trip/tests/slider_text.dart';
import 'file:///D:/FlutterProject/flutter_trip/lib/logins/snowflake_landing_widget.dart';
import 'package:flutter_trip/tests/snowflake_test.dart';
import 'package:flutter_trip/tests/float_button_text.dart';
import 'package:flutter_trip/tests/video_offical_text.dart';

class NetworkRequestTest extends StatefulWidget {
  @override
  _NetworkRequestTestState createState() => _NetworkRequestTestState();
}

class _NetworkRequestTestState extends State<NetworkRequestTest> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("测试")),
      ),
      body: ListView(
        children: [
          Wrap(
            children: [
              /**
               * Http页面
               */
              initPage("Http页面", Http_Test()),

              /**
               * Sp页面
               */
              initPage("SP页面", SPTest()),

              /**
               * ListVIew页面
               */
              initPage("GradView页面", GridView_Test()),
              /**
               *气泡登录页
               */
              initPage("气泡登录页", SnowflakeLandingWidget()),
              /**
               *
               */
              initPage("气泡登录页", SnowflakePage()),

              /**
               * Key测试
               */
              initKeyText(),
              /**
               * ListView
               */
              initPage("ListView", ListViewTextWidget()),

              /**
               * 测试NavigatorUtil
               */
              initPage("测试NavigatorUtil", AText()),

              /**
               * 富文本页面
               */
              initPage("富文本测试", RichTextWidget()),
              /**
               * 本地视屏播放页面
               */
              initPage(
                  "本地视频播放",
                  VideoPageWidget(
                    url: 'assets/video/kfc.mp4',
                    time: 5,
                    widget: MainPage(),
                  )),

              /**
               * 网络视频播放页面
               */
              initPage(
                  "网络视频播放",
                  VideoPageWidget(
                    url:
                    'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',
                    widget: MainPage(),
                    time: 10,
                    type: VideoPageEnum.network,
                  )),
              initPage("Video官方效果", VideoApp()),

              /***
               * Animated动画
               */
              initPage("Animated动画", AnimationTextWidget()),
              initPage("滑动条", SliderTextWidget()),
              initPage("Sliver大家族", CustomScrollWidget()),
              initPage("Sliver实战案例", CustomScrollWidget2()),
              initPage("常用炫酷插件", PlugWidget()),
              initPage("弹出Popup", ShowPopupWidget()),
              initPage("CupertinoPicker", CupertinoPickerWidget()),
              initPage("切换栏", FloatButtonWidget()),
              initPage("数据库", DBWidget()),
            ],
          ),
        ],

      ),
    );
  }

  GlobalKey _keyGreen = GlobalKey();

  initPage(String title, Widget httpTest) {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        child: Text(title),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return httpTest;
          }));
        },
      ),
    );
  }

  /// 获取当前Wiget位置 获取当前Wiget在屏幕中的位置
  Widget initKeyText() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 30),
        child: Text(
          "Key测试",
          textAlign: TextAlign.center,
        ),
      ),
      key: _keyGreen,
      onTap: () {
        //获取当前Widget大小
        final RenderBox renderBox = _keyGreen.currentContext.findRenderObject();
        final sizeGreen = renderBox.size;
        print("SIZEofgreen: $sizeGreen");

        //获取当前屏幕位置
        final positionGreen = renderBox.localToGlobal(Offset.zero);
        print("POSITIONofgreen: $positionGreen");
      },
    );
  }
}
