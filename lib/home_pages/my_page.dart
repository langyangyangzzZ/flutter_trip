import 'package:flutter/material.dart';
import 'package:flutter_trip/my_pages/setting_widget.dart';
import 'package:flutter_trip/util/entity_state.dart';
import 'package:flutter_trip/util/navigator_util.dart';

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
            initbackgroundimage(),

            //主布局
            Expanded(
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
            )
          ],
        ),

        //头布局
        _initHead()
      ],
    );
  }

  ///背景图片
  Image initbackgroundimage() {
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
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color:  EntityState.ThemeColor, width: 2),
            borderRadius: BorderRadius.circular(50)),
        child: Image.asset(
          "assets/images/flutterandroid1.png",
          height: 70,
          width: 70,
        ),
      ),
    );
  }
}
