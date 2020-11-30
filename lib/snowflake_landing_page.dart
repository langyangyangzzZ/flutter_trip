import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/main.dart';
import 'package:flutter_trip/util/gallery_unit.dart';

class Snowflake_landing_Page extends StatefulWidget {
  @override
  _Snowflake_landing_PageState createState() => _Snowflake_landing_PageState();
}

Color getRandomColor(Random random) {
  //透明度为0-255
  int a = random.nextInt(200);
  //这里设置的是白色透明度为0-200的圆
  return Color.fromARGB(a, 255, 255, 255);
}

class _Snowflake_landing_PageState extends State<Snowflake_landing_Page>
    with TickerProviderStateMixin {
  List<BubbleBean> _list = [];

  //随机数
  Random _random = new Random();

  //最大运行速度
  double _maxSpeed = 1.0;

  //最大的半径
  double _maxRadius = 100;

  //设置角度
  double _maxTheta = 2 * pi;

  AnimationController _animationController;
  AnimationController _tweenAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /**
     * 循环得到30个气泡
     */
    for (int i = 0; i < 30; i++) {
      BubbleBean bubbleBean = new BubbleBean();

      //获取随机透明度
      bubbleBean.color = getRandomColor(_random);

      //初始化设置位置
      bubbleBean.postion = Offset(-1, -1);

      /**
       *  _random.nextDouble() 获取的是0-1之间不为负数的小数
       */

      //设置随机运动
      bubbleBean.speed = _random.nextDouble() * _maxSpeed;

      //设置随机半径
      bubbleBean.radio = _random.nextDouble() * _maxRadius;

      //随机的角度
      bubbleBean.theta = _random.nextDouble() * _maxTheta;

      _list.add(bubbleBean);
    }

    //创建动画,执行为1秒
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));

    //动画监听器
    _animationController.addListener(() {
      setState(() {

      });
    });
    //渐变动画
    _tweenAnimation =
        new AnimationController(vsync: this, duration: Duration(seconds: 1));

    _tweenAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //重复执行气泡动画
        _animationController.repeat();
      }
    });
    //渐变动画开启
    _tweenAnimation.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _animationController = null;

    _tweenAnimation.dispose();
    _tweenAnimation = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //设置为屏幕为屏幕的宽 也可以使用MediaQuery.of(context).size.width
      width: double.infinity,
      //设置为屏幕为屏幕的高 也可以使用MediaQuery.of(context).size.height
      height: double.infinity,
      child: Stack(
        children: [
          //渐变背景
          buildGradientBackground(),
          // //随机气泡
          buildRandomBubble(context),
          // //高斯模糊
          buildGaussianBlur(),
          // // //Hellow Word
          buildTopText(),
          // // //底部输入框
          buildButtonTextField(),
        ],
      ),
    ));
  }

  //渐变背景
  buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,  //LinearGradient属性
              end: Alignment.bottomLeft,  //属性
              colors: [
                Colors.blue.withOpacity(0.3),
                Colors.blueAccent.withOpacity(0.3),
                Colors.lightBlueAccent.withOpacity(0.3),
                Colors.lightBlue.withOpacity(0.3),
              ]),
      ),
    );
  }

  ///随机气泡
  buildRandomBubble(BuildContext context) {
    return CustomPaint(
      painter: MyCustomPaint(_list, _random),
      //设置屏幕大小  MediaQuery.of(context).size是屏幕的宽和高
      size: MediaQuery.of(context).size,
    );
  }

  /**
   * 高斯模糊
   */
  buildGaussianBlur() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.3, sigmaY: 0.3),
      child: Container(
        color: Colors.white.withOpacity(0.2),
      ),
    );
  }

  //顶部Hellow Word文本
  buildTopText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 100),
      child: Text("Hellow Word",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 40,
              color: Colors.lightBlue,
              fontWeight: FontWeight.bold)),
    );
  }

  //底部按钮
  buildButtonTextField() {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 20,
      child: FadeTransition(
        //设置渐变动画
        opacity: _tweenAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyTextField("账号", Icon(Icons.format_list_numbered), false),
            SizedBox(
              height: 10,
            ),
            MyTextField("密码", Icon(Icons.qr_code), true),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return GalleryUnit();
                  }));
                },
                child: Text("注册", textAlign: TextAlign.center),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //跳转页面并吧当前状态取消掉
                  Navigator.pushAndRemoveUntil(context,
                      new MaterialPageRoute(builder: (BuildContext context) {
                    return MainPage();
                  }), (route) => route == null);
                },
                child: Text("登录", textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  String _lable;

  Icon _icon;

  bool isobscureText;

  MyTextField(this._lable, this._icon, this.isobscureText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: isobscureText,
        decoration: InputDecoration(
          //透明填充
          // filled: true,
          icon: _icon,
          labelText: _lable,
          //选中
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          //未选中
          /* enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                //不显示边框
                borderSide: BorderSide(color: Colors.black38))*/
        ),
      ),
    );
  }
}

class MyCustomPaint extends CustomPainter {

  Paint _paint = new Paint()
  //设置锯齿
    ..isAntiAlias = true;

  List<BubbleBean> _list;
  Random _random;
  MyCustomPaint(this._list, this._random);

  @override
  void paint(Canvas canvas, Size size) {

   _list.forEach((element) {
     //重新根据速度与运动角度计算Offset
      Offset newOffset = coordinates(element.speed, element.theta);

      print("szjpaintdx${newOffset.dx}paintdy${newOffset.dy}");
      double dx = newOffset.dx + element.postion.dx;
      double dy = newOffset.dy + element.postion.dy;

     /**
       * 通过if判断  保证dx坐标在屏幕里面
       */
      if (dx < 0 || dx > size.width) {
        //_random.nextDouble() 生成的是0-1之间不为负数的小数    size.width是屏幕的宽
        dx = _random.nextDouble() * size.width;
      }


       /*通过if判断  保证dy坐标在屏幕里面*/
      if (dy < 0 || dy > size.height) {
        //_random.nextDouble() 生成的是0-1之间不为负数的小数    size.height是屏幕的高
        dy = _random.nextDouble() * size.height;
      }

      element.postion = Offset(dx, dy);

      _paint.color = element.color;

    });

    //绘制
    _list.forEach((element) {
      canvas.drawCircle(element.postion, element.radio, _paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //刷新
    return true;
  }

  //重新计算Offset
  Offset coordinates(double speed, double theta) {
    return Offset(speed * sin(theta), speed * cos(theta));
  }
}

class BubbleBean {
  //位置
  Offset postion;

  //颜色
  Color color;

//运动的速度
  double speed;

  //运动的角度
  double theta;

  //半径
  double radio;
}
