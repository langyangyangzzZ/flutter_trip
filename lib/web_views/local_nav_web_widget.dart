import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:ui';

/// WebView使用flutter_webview_plugin插件
/// https://pub.dev/packages/flutter_webview_plugin
// ignore: must_be_immutable
class LocalNavWebWidget extends StatefulWidget {
  String title;
  String url;

  LocalNavWebWidget(this.url, this.title);

  @override
  _LocalNavWebWidgetState createState() =>
      _LocalNavWebWidgetState(title: title, url: url);
}

class _LocalNavWebWidgetState extends State<LocalNavWebWidget> {
  String url;
  String title;

  _LocalNavWebWidgetState({this.url, this.title});

  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<String> _urlChanged;
  StreamSubscription<WebViewStateChanged> _stateChanged;

  //网络错误
  StreamSubscription<WebViewHttpError> _httpErro;

  //攻略景点 周边游
  List<String> _urlList = [
    "https://m.ctrip.com/html5/",
  ];

  @override
  void initState() {
    super.initState();

    //关闭页面
    flutterWebviewPlugin.close();

    //返回的是当前的接口
    _urlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("SZJ_urlChanged$url");
    });

    //页面导航的状态
    _stateChanged = flutterWebviewPlugin.onStateChanged.listen((event) {
      print("SZJonStateChanged");
      switch (event.type) {
        case WebViewState.shouldStart:
          print("SZJshouldStart");
          break;
        case WebViewState.startLoad:
          print("SZJstartLoadUrl${event.url}");
          if (_isToFlutter(event.url)) {
            print("SZJNavigatorUrl${event.url}");
            Navigator.pop(context);
          }
          break;
        case WebViewState.finishLoad:
          print("SZJfinishLoad");
          break;
        case WebViewState.abortLoad:
          print("SZJabortLoad");
          break;
      }
    });

    //网络错误等情况返回监听
    _httpErro = flutterWebviewPlugin.onHttpError.listen((event) {
      print("SZJHttpErro网络错误");
    });
  }

  _isToFlutter(String url) {
    //默认不在里面
    bool isContaion = false;
    _urlList.forEach((element) {
      //判断接口是否相同
      if (url?.startsWith(element)) {
        isContaion = true;
      }
    });
    return isContaion;
  }

  @override
  void dispose() {
    super.dispose();
    _urlChanged.cancel();
    _stateChanged.cancel();
    _httpErro.cancel();
    flutterWebviewPlugin.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        ///隐藏Debug标志
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
          /**
               * MediaQueryData.fromWindow(window).padding.top)获取的是状态栏高度
               * 需导入import 'dart:ui';
               */
          padding:
              EdgeInsets.only(top: MediaQueryData.fromWindow(window).padding.top),
          child: WebviewScaffold(
            url: url,

            ///是否缩放
            withZoom: true,
            //是否缓存
            withLocalStorage: true,
            //默认状态
            hidden: true,
            //这三个参数解决的是在android端网页自动放大问题
            useWideViewPort: true,
            displayZoomControls: true,
            withOverviewMode: true,
            //当WebView没加载出来前显示
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text("正在加载中...."),
              ),
            ),
          ),
        )),
      );
    }
}
