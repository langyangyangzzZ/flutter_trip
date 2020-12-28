import 'package:flutter/material.dart';
import 'package:flutter_trip/flare_demo/flare_sign_in_demo.dart';
import 'package:flutter_trip/tests/snowflake_landing_text.dart';
import 'package:flutter_trip/util/entity_state.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/util/providers.dart';
import 'package:flutter_trip/util/sp_util.dart';
import 'package:provider/provider.dart';

void main() {
    /*
      改变状态栏颜色为透明
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
   */
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
    home: snowflake_landing_page(),
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

