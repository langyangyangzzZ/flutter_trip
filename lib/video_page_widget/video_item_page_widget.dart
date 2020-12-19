import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_trip/tests/video_page_widget.dart';
import 'package:flutter_trip/util/log_util.dart';
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
          onTap: () {
            isCheck = !isCheck;
            if (isCheck) {
              //点击开始按钮开始播放
              if (widget.streamController != null) {
                widget.streamController.add(_controller);
              }
              _controller.play();
            } else {
              //暂停播放
              _controller.pause();
            }

            setState(() {});
          },
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
}
