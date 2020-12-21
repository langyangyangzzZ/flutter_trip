import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_trip/util/log_util.dart';

class AnimationTextWidget extends StatefulWidget {
  @override
  _AnimationTextWidgetState createState() => _AnimationTextWidgetState();
}

class _AnimationTextWidgetState extends State<AnimationTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 30),
      child: Column(
        children: [
          initButton("AnimatedContainer按钮", 1),
          initAnimatedContainer(),

          initButton("AnimatedOpacity按钮", 2),
          initAnimatedOpactiy(),

          initButton("AnimatedAlign按钮", 3),
          initAnimatedAlign(),
        ],
      ),
    );
  }

//属性使用变量，当变量值改变时可以看到容器改变的动画。
  Widget initAnimatedContainer() {
    return AnimatedContainer(
      padding: EdgeInsets.only(left: 30, top: 40),
      alignment: Alignment.center,
      // 定义动画需要多长时间
      duration: Duration(milliseconds: 1000),
      // 提供一个可选的曲线，使动画感觉更流畅。
      curve: Curves.fastOutSlowIn,
      //长度宽度使用变量  实现组件缩放动画
      width: _width,
      height: _height,
      child: Text(
        "AnimatedContainer动画",
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
      decoration: BoxDecoration(
        //颜色 圆角度使用变量
        color: _color,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  double _width = 50;
  double _height = 50;
  Color _color = new Color(int.parse("0XFF090B30"));
  double radius = 20;

  List<String> _list = [
    "0XFF3F48CC",
    "0XFF00A2E8",
    "0XFF090B30",
    "0XFFED1C24",
    "0XFF31B157",
    "0XFFA349A4"
  ];
  Random random = new Random();

  initButton(String s, int type) {
    return ElevatedButton(
      onPressed: () {
        if (type == 1) {
          // AnimatedContainer
          buildAnimatedContainer();
        } else if (type == 2) {
          buildAnimatedOpacity();
        } else if (type == 3) {
          LogUtil.Log(tagging: "buildAnimatedAlign:", title: "${_x}+_y:${_y}");
          buildAnimatedAlign();
        }
      },
      child: Text(s),
    );
  }

  // AnimatedContainer
  void buildAnimatedContainer() {
    _width += 50;
    _height += 100;
    radius += 10;
    LogUtil.Log(
        tagging: "随机颜色为: ", title: "${_list[random.nextInt(_list.length)]}");
    _color = new Color(int.parse(_list[random.nextInt(_list.length)]));
    if (_width > 300) {
      _width = 50;
    }
    if (_height > 200) {
      _height = 50;
    }
    if (radius > 50) {
      radius = 10;
    }
    setState(() {});
  }

  bool isOpacity = false;

  Widget initAnimatedOpactiy() {
    return AnimatedOpacity(
      duration: new Duration(seconds: 2),
      opacity: isOpacity ? 1 : 0,
      child: Container(
        width: 100,
        height: 100,
        color: Colors.lightGreenAccent,
        child: Text("AnimatedOpcatiy",style: TextStyle(color: Colors.black,fontSize: 10),),
      ),
    );
  }

  void buildAnimatedOpacity() {
    setState(() {
      isOpacity = !isOpacity;
    });
  }

  double _x = 0;
  double _y = 0;

  Widget initAnimatedAlign() {
    return Container(
      height: 300,
      color: Colors.red,
      child: AnimatedAlign(
        duration: new Duration(seconds: 2),
        alignment: Alignment(_x, _y),
        child: Container(
          width: 100,
          height: 100,
          color: Colors.cyan,
        ),
      ),
    );
  }

  void buildAnimatedAlign() {
    _x == 0 ? _x = -1 : _x = 0;
    _y == 0 ? _y = -1 : _y = 0;

    setState(() {});
  }
}
