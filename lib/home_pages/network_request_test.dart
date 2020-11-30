import 'package:flutter/material.dart';
import 'package:flutter_trip/beans/chicken_soup_bean.dart';
import 'package:flutter_trip/tests/http_test.dart';
import 'package:flutter_trip/tests/listview_test.dart';
import 'package:flutter_trip/tests/shared_perferences_test.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkRequestTest extends StatefulWidget {
  @override
  _NetworkRequestTestState createState() => _NetworkRequestTestState();
}

class _NetworkRequestTestState extends State<NetworkRequestTest> {
  var _httpGet;

  @override
  void initState() {
    _httpGet = _HttpGet();
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
          initRpute("Http页面",Http_Test()),

          /**
           * Sp页面
           */
          initRpute("Http页面",SPTest()),

          /**
           * ListVIew页面
           */
          initRpute("ListView页面",ListView_Test()),





        ],
      ),
    );
  }

  /**
   *   异步请求网络数据
   */
  Future<ChickenSoupBean> _HttpGet() async {
    var responce = await http.get("https://v1.hitokoto.cn/");
    //UTF-8防止乱码
    Utf8Codec utf8codec = Utf8Codec();
    //序列化返回数据
    final decode = json.decode(utf8codec.decode(responce.bodyBytes));
    return ChickenSoupBean.fromJson(decode);
  }

  initRpute(String title, Widget http_test) {
    return RaisedButton(
      child: Text(title),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return http_test;
        }));
      },
    );
  }
}
