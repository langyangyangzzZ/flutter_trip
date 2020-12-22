import 'package:flutter/material.dart';
import 'package:flutter_trip/home_page_widget/user_agreement_model.dart';
import 'package:flutter_trip/home_pages/home_page.dart';
import 'package:flutter_trip/home_pages/my_page.dart';
import 'package:flutter_trip/home_pages/network_request_test.dart';
import 'package:flutter_trip/home_pages/root_page.dart';
import 'package:flutter_trip/home_pages/video_page.dart';
import 'package:flutter_trip/home_pages/trip_page.dart';
import 'package:flutter_trip/tests/rich_text.dart';
import 'package:flutter_trip/tests/snowflake_landing_text.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/util/permission_util.dart';
import 'package:flutter_trip/util/sp_util.dart';

void main() {
  //改变状态栏颜色为透明
  // SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:Colors.transparent);
  // SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(MaterialApp(
    //气泡动画
    home: Snowflake_landing_Page(),

    debugShowCheckedModeBanner: false,

    //小熊动画
    // home: FlareDemo(),

  ));
}


