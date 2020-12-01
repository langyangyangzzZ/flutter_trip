import 'dart:math';

import 'package:flutter/material.dart';

class SnowflakePage extends StatefulWidget {
  @override
  _SnowflakePageState createState() => _SnowflakePageState();
}

class _SnowflakePageState extends State<SnowflakePage>
    with TickerProviderStateMixin {
  //随机数
  Random _random = new Random();

  List<SnowBean> _list = [];
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 0), () {
      initData();
    });

    //创建动画,执行为1秒
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 10));

    //动画监听器
    _animationController.addListener(() {
      setState(() {});
    });

    //重复执行气泡动画
    _animationController.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: CustomPaint(
        painter: MyCustomPainter(_list, _random),
        size: MediaQuery.of(context).size,
      ),
    );
  }

  void initData() {
    for (int i = 0; i <= 200; i++) {
      SnowBean snowBean = new SnowBean();

      double dx = _random.nextDouble() * MediaQuery.of(context).size.width;
      double dy = _random.nextDouble() * MediaQuery.of(context).size.height;
      snowBean.postion = Offset(dx, dy);
      snowBean.radius = _random.nextDouble() + 1;
      snowBean.speed = _random.nextDouble() + 5;

      _list.add(snowBean);
    }
  }
}

class MyCustomPainter extends CustomPainter {
  List<SnowBean> list;
  Random _random;
  MyCustomPainter(this.list, this._random);
  Paint _paint = new Paint()
    ..isAntiAlias = true
    ..color = Colors.white;

  @override
  void paint(Canvas canvas, Size size) {


    list.forEach((element) {
      double dy = element.postion.dy;
      double dx = element.postion.dx;

      /**
       * 若Y轴雪花移动到屏幕以外,则让它回到起始位置
       */
      if (dy >= size.height) {
        dy = 0;
      }
      /**
       * 若X轴雪花移动到屏幕以外,则让它回到起始位置
       */
      if (dx >= size.width) {
        dx = 0;
      }

      element.postion =
          Offset(dx + _random.nextDouble(), dy +  element.speed);
    });

    list.forEach((element) {
      canvas.drawCircle(element.postion, element.radius, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //是否刷新 true 刷新
    return true;
  }
}

class SnowBean {
  //位置
  Offset postion = Offset(100, 100);

  //半径
  double radius = 50;

  //移动速度
  double speed;
}
