import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/my_pages/setting_widget.dart';
import 'file:///D:/FlutterProject/flutter_trip/lib/logins/snowflake_landing_widget.dart';
import 'package:flutter_trip/util/entity_state.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/util/sp_util.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: initStack(),
    );
  }

  Widget initStack() {
    return Stack(
      children: [
        Column(
          children: [
            //背景图片
            initBackgroundImage(),

            //主布局
            initMain(),
          ],
        ),

        //头布局
        _initHead()
      ],
    );
  }

  Expanded initMain() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("设置"),
              trailing: Icon(Icons.keyboard_return),
              onTap: () => NavigatorUtil.pushPage(
                  context: context, widget: SettingWidget()),
            ),
          ],
        ),
      ),
    );
  }

  ///背景图片
  Image initBackgroundImage() {
    return Image.asset(
      "assets/images/flutter.jpg",
      fit: BoxFit.fill,
      height: 180,
    );
  }

  Positioned _initHead() {
    return Positioned(
      top: 140,
      left: 50,
      child: GestureDetector(
        onTap: () {
          SpUtil.getDate<bool>(EntityState.spIsLogin).then((value) {
            if (value == null || !value) {
              NavigatorUtil.pushPage(
                  context: context, widget: SnowflakeLandingWidget());
            } else {
              initCancel();
            }
          });
        },
        child: Hero(
          tag: EntityState.heroHeadImageToLogin,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: EntityState.themeColor, width: 2),
                borderRadius: BorderRadius.circular(50)),
            child: Image.asset(
              "assets/images/flutterandroid1.png",
              height: 70,
              width: 70,
            ),
          ),
        ),
      ),
    );
  }

  //注销登陆页面
  void initCancel() {
    showCupertinoDialog(
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Text("您已经登陆,是否注销 : )"),
            actions: [
              CupertinoDialogAction(
                child: Text("取消"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text("确定"),
                onPressed: () {
                  SpUtil.setData<bool>(EntityState.spIsLogin, false);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
        context: context);
  }
}
