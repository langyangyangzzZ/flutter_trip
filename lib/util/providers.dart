import 'package:flutter/material.dart';

/*
 * @ClassName providers
 * 作者: szj
 * 时间: 2020/12/26 14:27
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class AppInfoProvider with ChangeNotifier {
  //主题颜色
  String _themeColor = '';

  //主题模式 白天/夜间
  String _themeMode = '';

  String get themeColor => _themeColor;

  // ignore: missing_return
  String get themeMode => _themeMode;

  //设置主题颜色
  setTheme(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }

  ///设置夜间模式
  setNight(String mode) {
    _themeMode = mode;
    notifyListeners();
  }


}
