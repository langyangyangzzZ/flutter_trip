import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
 * @ClassName entaty_state
 * 作者: szj
 * 时间: 2020/12/26 10:33
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class EntityState {
   /*
      请注意代码规范:
        static String aaaBbb;
        static final  String aaaBbb;
   */

  static Random random = new Random();
  // -------------- SP ----------------------

  //SP保存当前夜间模式   true夜间模式 false白天模式
  static final String spNight = "isNight";

  //Sp保存是否登陆Key  true登陆
  static final String spIsLogin = "spIsLogin";

  static final String spIsOneLogin = "spIsOneLogin";

  // ----------------Hero ---------------------
  //Hero动画 ImageHead 跳转 Login
  static final String heroHeadImageToLogin = "heroHeadImageToLogin";

  //Hero动画 video放大功能
  static final String heroVideoToFullScreen = "heroVideoToFullScreen";


  // ---------------Color -------------------
  //当前主题色  默认为蓝色
  static Color themeColor = Colors.blue;

  // --------------- Map,List-------------------------
  //主题颜色
  static Map<String, Color> themeColorMap = {
    'gray': Colors.grey,
    'blue': Colors.blue,
    'blueAccent': Colors.blueAccent,
    'cyan': Colors.cyan,
    'deepPurple': Colors.purple,
    'deepPurpleAccent': Colors.deepPurpleAccent,
    'deepOrange': Colors.orange,
    'green': Colors.green,
    'indigo': Colors.indigo,
    'indigoAccent': Colors.indigoAccent,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'red': Colors.red,
    'teal': Colors.teal,
    'black': Colors.black,
  };

  //主题模式
  static Map<String, Brightness> brightnessColorMap = {
    'dark': Brightness.dark,
    'light': Brightness.light,
  };

  //video视频
  static List<String> videoList = [
    "assets/videos/kfc.mp4",
    "assets/videos/wyy1.mp4",
    "assets/videos/wwy2.mp4"
  ];






  //随机视频播放
  static String getRandomVideo() {
    return videoList[random.nextInt(videoList.length )];
  }

  //横屏
  static void setHorizontal(){
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  //竖屏
  static void setVertical(){
    // 强制竖屏
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  //修改顶部状态栏颜色
  static void setStatusBarColor(Color color){
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:color);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
