import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_trip/home_pages/root_page.dart';
import 'package:flutter_trip/logins/video_page_widget.dart';
import 'package:flutter_trip/util/entity_state.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/util/providers.dart';
import 'package:flutter_trip/util/sp_util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //有多个状态管理就使用 MultiProvider，单个的使用 Provider.value 就行了
    MultiProvider(
      //全局状态管理
      providers: [ChangeNotifierProvider.value(value: AppInfoProvider())],

      // ignore: missing_required_param
      child: Consumer<AppInfoProvider>(
        builder: (context, appInfo, child) {
          return _initMaterialApp(appInfo);
        },
      ),
    ),
  );
}

MaterialApp _initMaterialApp(AppInfoProvider appInfo) {
  return MaterialApp(
    // //气泡动画
    home: VideoPageWidget(
      //随机视频播放
      url: EntityState.getRandomVideo(),
      //要跳转的页面
      widget: MainPage(),
    ),
    theme: ThemeData(
      //主题模式
      primaryColor: EntityState.themeColorMap[appInfo.themeColor],
      //夜间模式
      brightness: EntityState.brightnessColorMap[appInfo.themeMode],
    ),

    //取消Debug标志
    debugShowCheckedModeBanner: false,
  );
}

//true登陆 false 不登录
bool isLogin = false;

bool initLogin() {
  //判断是否是第一次登陆
  SpUtil.getDate<bool>(EntityState.spIsOneLogin).then((value) {
    if (value != null) {
      LogUtil.LogI("$value", tagging: "valueSp:");
      isLogin = value;
    }
  }).whenComplete(() {
    return isLogin;
  });
}
