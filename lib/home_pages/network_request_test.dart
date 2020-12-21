import 'package:flutter/material.dart';
import 'package:flutter_trip/main.dart';
import 'package:flutter_trip/tests/a_test.dart';
import 'package:flutter_trip/tests/animation_text.dart';
import 'file:///D:/FlutterProject/flutter_trip/lib/tests/snowflake_landing_text.dart';
import 'package:flutter_trip/tests/http_test.dart';
import 'package:flutter_trip/tests/gridview_test.dart';
import 'package:flutter_trip/tests/listview_text.dart';
import 'package:flutter_trip/tests/rich_text.dart';
import 'package:flutter_trip/tests/shared_perferences_test.dart';
import 'package:flutter_trip/tests/snowflake_test.dart';
import 'package:flutter_trip/tests/video_offical_text.dart';
import 'package:flutter_trip/tests/video_page_widget.dart';
import 'package:flutter_trip/tests/video_player_text.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: Text("刷新"),
      ),
      body: Column(
        children: [
          /**
           * Http页面
           */
          initPage("Http页面", Http_Test()),

          /**
           * Sp页面
           */
          initPage("Http页面", SPTest()),

          /**
           * ListVIew页面
           */
          initPage("GradView页面", GridView_Test()),
          /**
           *气泡登录页
           */
          initPage("气泡登录页", Snowflake_landing_Page()),
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
              "本地视频播放", VideoPageWidget(url: 'assets/video/kfc.mp4', time: 5, widget: MainPage(),)),

          /**
           * 网络视频播放页面
           */
          initPage(
              "网络视频播放",
              VideoPageWidget(
                url:
                    'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4',widget: MainPage(),
                time: 10,
                type: VideoPageEnum.network,
              )),

          initPage("Video官方效果", VideoApp()),

          /***
           * Animated动画
           */
          initPage("Animated动画", AnimationTextWidget()),
        ],
      ),
    );
  }

  GlobalKey _keyGreen = GlobalKey();

  initPage(String title, Widget httpTest) {
    return RaisedButton(
      child: Text(title),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return httpTest;
        }));
      },
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
