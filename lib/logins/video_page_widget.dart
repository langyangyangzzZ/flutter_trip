import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_trip/logins/video_player_text.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/util/toast.dart';

/// 1217
/// szj
/// 公众号:码上变有钱
/// 微信号:ohhzzZ77
/// CSDN:https://blog.csdn.net/weixin_44819566
/// video_player: ^1.0.1 # 视屏播放   https://pub.dev/packages/video_player/install
class VideoPageWidget extends StatefulWidget {
  String url;
  int time; //默认5s

  ///VideoPageEnum.asset 本地视屏
  /// VideoPageEnum.network 网络视频
  VideoPageEnum type;
  Widget widget;

  /// [url] 路径地址
  /// [time] 倒计时时间
  /// [type] VideoPageEnum.asset本地视频(默认)  VideoPageEnum.network 网络视频
  /// [widget] 要跳转的页面
  VideoPageWidget({
    @required this.url,
    this.time = 5,
    this.type = VideoPageEnum.asset,
    @required this.widget,
  });

  @override
  _VideoPageWidgetState createState() => _VideoPageWidgetState();
}

class _VideoPageWidgetState extends State<VideoPageWidget> {
  Timer _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //1s执行一下
    _timer = Timer.periodic(new Duration(seconds: 1), (value) {
      if (widget.time == 1) {
        //关闭
        _timer.cancel();
        Toast.toast(context, msg: "已跳转");
        goHome();
      }
      widget.time--;
      setState(() {});
      print("time: ${widget.time},value:$value");
    });
  }

  @override
  void dispose() {
    LogUtil.Log(title: "dispose", tagging: "dispose");
    //退出时将时间改为5
    widget.time = 5;
    //计时器是否是活动状态
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //视屏播放
          VideoPlayerWidget(url: widget.url),

          //右上角跳转
          Positioned(
            child: GestureDetector(
                onTap: () {
                  goHome();
                },
                child: buildContainer(context)),
            right: 20,
            top: 40,
          ),
        ],
      ),
    );
  }

  //倒计时按钮布局
  Widget buildContainer(BuildContext context) {
    return Container(
      width: 100,
      height: 30,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      alignment: Alignment.center,
      child: Text(
        '${widget.time}s',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  void goHome() {
    NavigatorUtil.pushColsePage(
      context: context,
      widget: widget.widget,
    );
  }
}

enum VideoPageEnum {
  //本地视频 通过assets下的video引用
  asset,
  // 网络 视频
  network
}
