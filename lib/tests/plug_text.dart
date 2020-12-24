import 'package:flutter/material.dart';
import 'package:flutter_echart/flutter_echart.dart';

/*
 * @ClassName plug_text
 * 作者: szj
 * 时间: 2020/12/23 16:55
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 *
 * 炫酷插件
 */
class PlugWidget extends StatefulWidget {
  @override
  _PlugWidgetState createState() => _PlugWidgetState();
}

class _PlugWidgetState extends State<PlugWidget> {
  List<EChartPieBean> _dataList = [
    EChartPieBean(title: "生活费", number: 100, color: Colors.lightBlueAccent),
    EChartPieBean(title: "游玩费", number: 200, color: Colors.deepOrangeAccent),
    EChartPieBean(title: "交通费", number: 400, color: Colors.green),
    EChartPieBean(title: "贷款费", number: 300, color: Colors.amber),
    EChartPieBean(title: "电话费", number: 200, color: Colors.orange),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          buildPieChatWidget(),
        ],
      ),
    );
  }


  PieChatWidget buildPieChatWidget() {
    return PieChatWidget(
      dataList: _dataList,
      //是否输出日志
      isLog: true,
      //是否需要背景
      isBackground: true,
      //是否画直线
      isLineText: true,
      //背景
      bgColor: Colors.white,
      //是否显示最前面的内容
      isFrontgText: true,
      //默认选择放大的块
      initSelect: 1,
      //初次显示以动画方式展开
      openType: OpenType.ANI,
      //旋转类型
      loopType: LoopType.DOWN_LOOP,
      //点击回调
      clickCallBack: (int value) {
        print("当前点击显示 $value");
      },
    );
  }
}
