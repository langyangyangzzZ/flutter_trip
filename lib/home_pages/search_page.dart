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
  var _httpGet;
  @override
  void initState() {
    _httpGet= _HttpGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text("搜索")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {

          });
        },
        child: Text("刷新"),
      ),
      body: Column(
        children: [
          Center(
              child: Column(
            children: [
              InkWell(
                onTap: () {
                  Future.delayed(new Duration(seconds: 2)).then((value) {
                    print("Future.delayed:我是老大,但我在两秒之后执行的");
                  });
                  print("Future.delayed:我是老二,我先执行");

                  _HttpGet().then((ChickenSoupBean value) {
                    setState(() {
                      _mValue = "\n${value.hitokoto}\n---${value.fromWho}";
                      print("Future:${value.toString()}");
                    });
                  }, onError: (onErr) {
                    print("Future:onError错误${onErr}");
                  }).catchError((onCatchError) {
                    print("Future:catchErrorr错误${onCatchError}");
                  }).whenComplete(() => {
                        print("Future:代码执行完啦!!"),
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
          FutureBuilder<ChickenSoupBean>(
            //异步请求的接口
            future: _HttpGet(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //判断snapshot连接状态  ConnectionState.done连接成功
              if (snapshot.connectionState == ConnectionState.done) {
                /**
                 * 判断数据是否返回成功
                 * 也可以通过snapshot.hashData 判断数据是否返回成功
                 */
                if (snapshot.hasError) {
                  return Text("HasError");
                } else {
                  return Text(
                      "${snapshot.data.hitokoto}\n----${snapshot.data.fromWho}");
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  /**
   *   异步请求网络数据
   */
  Future<ChickenSoupBean> _HttpGet() async {
      var   responce =  await http.get("https://v1.hitokoto.cn/");
    //UTF-8防止乱码
    Utf8Codec utf8codec = Utf8Codec();
    //序列化返回数据
    final decode = json.decode(utf8codec.decode(responce.bodyBytes));
   return  ChickenSoupBean.fromJson(decode);

  }
}
