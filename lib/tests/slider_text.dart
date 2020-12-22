import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/util/toast.dart';

/*
 * @ClassName slider_text
 * 作者: szj
 * 时间: 2020/12/22 14:01
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class SliderTextWidget extends StatefulWidget {
  @override
  _SliderTextWidgetState createState() => _SliderTextWidgetState();
}

class _SliderTextWidgetState extends State<SliderTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          Text("普通滑动条"),
          //普通滑动条
          initSilder(),

          Text("苹果风格滑动条"),
          //苹果风格滑动条
          initCupertinoSlider()
        ],
      ),
    );
  }

  double _slidervalue = 0.0;

  //普通滑动条Slider
  Widget initSilder() {
    return Container(
      height: 100,
      child: Slider(
        //分段提示 配合divisions使用
        label: "$_slidervalue _slidervalue",

        ///将视频分为5段 只能滑动到5段上的某个位置
        divisions: 5,

        ///已滑动过得颜色
        activeColor: Colors.red,

        ///未滑动的颜色
        inactiveColor: Colors.cyan,

        ///默认为0.0。必须小于或等于[最大值]
        ///如果[max]等于[min]，则滑块被禁用。
        min: 0,

        ///默认为1.0。必须大于或等于[min]。
        ///如果[max]等于[min]，则滑块被禁用。
        max: 1,

        ///当前进度 取值(0 - 1)
        value: _slidervalue,

        //进度条进度 返回值为(0-1)
        onChanged: (double value) {
          setState(() {
            _slidervalue = value;
            //拖动进度条改变视频长度
          });
        },
        //滑动开始回调
        onChangeStart: (double value) {
          Toast.toast(context, msg: "滑动开始$value");
        },
        //滑动结束回调
        onChangeEnd: (double value) {
          Toast.toast(context, msg: "滑动结束$value");
        },
      ),
    );
  }

  /// 苹果风格滑动条
  Widget initCupertinoSlider() {
    return CupertinoSlider(
      // ///将视频分为5段 只能滑动到5段上的某个位置
      divisions: 5,

      ///已滑动过得颜色
      activeColor: Colors.red,

      ///未滑动的颜色
      thumbColor: Colors.cyan,

      ///默认为0.0。必须小于或等于[最大值]
      ///如果[max]等于[min]，则滑块被禁用。
      min: 0,

      ///默认为1.0。必须大于或等于[min]。
      ///如果[max]等于[min]，则滑块被禁用。
      max: 1,

      ///当前进度 取值(0 - 1)
      value: _slidervalue,

      //进度条进度 返回值为(0-1)
      onChanged: (double value) {
        setState(() {
          _slidervalue = value;
          //拖动进度条改变视频长度
        });
      },
      //滑动开始回调
      onChangeStart: (double value) {
        Toast.toast(context, msg: "滑动开始$value");
      },
      //滑动结束回调
      onChangeEnd: (double value) {
        Toast.toast(context, msg: "滑动结束$value");
      },
    );
  }
}
