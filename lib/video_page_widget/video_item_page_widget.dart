import 'dart:async';

import 'package:flutter/material.dart';
import 'file:///D:/FlutterProject/flutter_trip/lib/logins/video_page_widget.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/util/toast.dart';
import 'package:video_player/video_player.dart';

/*
 * @ClassName video_item_page_widget
 * 作者: szj
 * 时间: 2020/12/18 11:12
 */
// ignore: must_be_immutable
class VideoItemPageWidget extends StatefulWidget {
  String url;

  ///VideoPageEnum.asset 本地视屏
  /// VideoPageEnum.network 网络视频
  VideoPageEnum type;

  //全局流控制器,用来监听控制视频播放器
  StreamController streamController;

  //ListView是否在滑动
  bool isScroll;

  VideoItemPageWidget({
    @required this.url, //路径
    this.streamController,
    this.isScroll, //是否播放
    this.type = VideoPageEnum.asset, //默认为传递本地视频
  });

  @override
  _VideoItemPageWidgetState createState() => _VideoItemPageWidgetState();
}

class _VideoItemPageWidgetState extends State<VideoItemPageWidget>
    with TickerProviderStateMixin {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.type == VideoPageEnum.asset
        ? VideoPlayerController.asset(widget.url)
        : VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      // isCheck 当前是否是播放状态
      // _controller.value.isPlaying 如果正在播放视频，则为True。如果暂停，则为False。
      // 如果当前标识是播放状态,但是播放器已经不播放了 则吧标识改变成不播放状态 跟随播放器改变而改变
      if (isCheck && !_controller.value.isPlaying) {
        isCheck = false;
        LogUtil.Log(tagging: "ischeck", title: '$isCheck');
        setState(() {});
      }


      setState(() {
        //使进度条跟随视频的变化而变化  当前进度 = 当前播放视频 / 总视频长度
        _slidervalue = _controller.value.position.inMilliseconds /
            _controller.value.duration.inMilliseconds;
      });
    });
  }

  bool isCheck = false; //true 播放 false不播放

  @override
  Widget build(BuildContext context) {
    /*
       widget.isScroll 当前是否是滚动状态
     */
    return widget.isScroll
        ? Center(
            child: Text("加载中..."),
          )
        //视频播放器页面
        : buildLayout();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /*
   * 视频播放器和控制器布局
   */
  Widget buildLayout() {
    return Stack(
      children: [
        //占满全屏 并 播放视频
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ),

        //编辑透明文字
        buildText(),

        //编辑滑动条
        Positioned(
          bottom: 2,
          right: 10,
          left: 10,
          child: isCheck ? Container() : buildSilder(),
        ),
      ],
    );
  }

  //编辑透明文字
  Widget buildText() {
    return Positioned.fill(
      //透明动画
      child: AnimatedOpacity(
        //当 按钮文字问"开始"时,不显示当前文字
        opacity: isCheck ? 0 : 1,
        duration: new Duration(seconds: 1),
        child: GestureDetector(
          onTap: buildonTagText,
          child: Container(
            color: Colors.grey.withOpacity(0.5),
            child: Center(
              child: Text(
                "开始",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///点击按钮监听事件
  buildonTagText() {
    isCheck = !isCheck;
    if (isCheck) {
      //点击开始按钮开始播放
      if (widget.streamController != null) {
        widget.streamController.add(_controller);
      }

      //视频当前进度
      Duration position = _controller.value.position;
      //视频总长度
      Duration duration = _controller.value.duration;
      //当播放完成之后,返回到初始位置
      if (position == duration) {
        _controller.seekTo(Duration.zero);
      }
      _controller.play();
    } else {
      //暂停播放
      _controller.pause();
    }
    setState(() {});
  }

  //当前播放视频进度条进度
  double _slidervalue = 0.0;

  //滑动进度条
  Widget buildSilder() {
    return Row(
      children: [
        //开始进度
        Text(
          buildTextString(_controller.value.position),
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        //进度条
        initSilder(),
        //总进度
        Text(
          buildTextString(_controller.value.duration),
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  String buildTextString(Duration duration) {
    // 返回此持续时间跨越的整秒数。
    int inSeconds = duration?.inSeconds;
    // 返回此持续时间跨越的整分钟数。
    int inMinutes = duration?.inMinutes;

    String time = "";
    try{
      time = "$inMinutes.${inSeconds % 60}";
    }catch(e){
      LogUtil.Log(tagging: "catchLogUtil",title: e.toString());
    }
    return time;
  }

  //初始化Slider
  Widget initSilder() {
    return Expanded(
      child: Slider(
        //分段提示 配合divisions使用
        // label: "$_slidervalue _slidervalue",
        //
        // ///将视频分为5段 只能滑动到5段上的某个位置
        // divisions: 5,

        ///已滑动过得颜色
        activeColor: Colors.red,

        ///未滑动的颜色
        inactiveColor: Colors.cyan,

        ///默认为0.0。必须小于或等于[最大值]
        ///如果[max]等于[min]，则滑块被禁用。
        min:  0,

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
            _controller.seekTo(_controller.value.duration * value);
          });
        },
        //滑动开始回调
        onChangeStart: (double value){
          // Toast.toast(context,msg: "滑动开始$value");
        },
        //滑动结束回调
        onChangeEnd: (double value){
          // Toast.toast(context,msg: "滑动结束$value");
        },
      ),
    );
  }
}
