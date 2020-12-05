import 'dart:convert';

import 'package:flutter_trip/beans/home_bean.dart';

import 'package:http/http.dart' as http;

class Dao {
  /**
   * 首页接口
   */
  final String HomeUrl = "https://www.devio.org/io/flutter_app/json/home_page.json";

  Future<HomeBean>  home_data() async {
    final responce = await http.get(HomeUrl);
    /**
     * 防止中文乱码
     */
    Utf8Codec utf8codec = new Utf8Codec();
    final decode = json.decode(utf8codec.decode(responce.bodyBytes));
    return HomeBean.fromJson(decode);
  }
}
