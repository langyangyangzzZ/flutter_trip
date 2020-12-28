import 'package:flutter/material.dart';

/*
 * @ClassName entaty_state
 * 作者: szj
 * 时间: 2020/12/26 10:33
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class EntityState{

  //SP保存当前夜间模式   true夜间模式 false白天模式
  static final  String  SpNight = "isNight";

  //当前主题色  默认为蓝色
  static Color ThemeColor  = Colors.blue;

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

  static Map<String , Brightness> brightnessColorMap = {
    'dark': Brightness.dark,
    'light': Brightness.light,
  };
}
