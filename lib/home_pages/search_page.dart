import 'package:flutter/material.dart';
import 'package:flutter_trip/beans/chicken_soup_bean.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String _mValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("搜索")),
      ),
      body: Center(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              _HttpGet().then((ChickenSoupBean value)  {
                    setState(() {
                      _mValue =  value.hitokoto;
                      print("value${value}");
                    });
                  });
            },
            child: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text("点我获取Http网络数据"),
            ),
          ),
          Container(
            child: Text(_mValue),
          )
        ],
      )),
    );
  }

  /**
   *   异步请求网络数据
   */
  Future<ChickenSoupBean> _HttpGet() async {
    final responce = await http.get("https://v1.hitokoto.cn/");

    print("statusCode = ${responce.statusCode}body:${responce.body}");

    //序列化返回数据
    final decode = json.decode(responce.body);
    return ChickenSoupBean.fromJson(decode);
  }
}
