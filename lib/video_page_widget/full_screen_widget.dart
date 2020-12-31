import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trip/logins/video_page_widget.dart';
import 'package:flutter_trip/util/entity_state.dart';
import 'package:video_player/video_player.dart';

/*
 * @ClassName full_screen_widget
 * 作者: szj
 * 时间: 2020/12/31 10:54
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class FullScreenWidget extends StatefulWidget {
  String url;
  VideoPageEnum videoPageEnum;

  FullScreenWidget({@required this.url, this.videoPageEnum});

  @override
  _FullScreenWidgetState createState() => _FullScreenWidgetState();
}

class _FullScreenWidgetState extends State<FullScreenWidget> {
  VideoPlayerController _controller;

  //是否是横屏  默认横屏
  bool isHorizontal = true;

  @override
  void initState() {
    super.initState();
    //判断是否是本地视频
    _controller = widget.videoPageEnum == VideoPageEnum.asset
        ? VideoPlayerController.asset(widget.url)
        : VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

    _controller.addListener(() {
      //当前进度  == 总进度
      if (_controller.value.position == _controller.value.duration) {
        //表示已经播放完
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pop();
        });
      }
    });

    //将状态栏的颜色改变为透明
    EntityState.setStatusBarColor(Colors.transparent);

    //设置横屏
    EntityState.setHorizontal();
  }

  @override
  void dispose() {
    _controller.dispose();

    //设置竖屏
    EntityState.setVertical();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Stack(
          children: [
            //初始化视频
            initVideo(),
            //初始化开始按钮
            initStartButton(),

            //返回
            initPopButton(),
          ],
        ),
      ),
    );
  }

  Center initVideo() {
    return Center(
      child: _controller.value.initialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }

  Positioned initStartButton() {
    return Positioned.fill(
      child: Stack(
        children: [
          //初始化渐变开始按钮
          initOpacityStartButton(),

          //横屏竖屏按钮
          initPosition(),
        ],
      ),
    );
  }

  AnimatedOpacity initOpacityStartButton() {
    return AnimatedOpacity(
      opacity: !_controller.value.isPlaying ? 1 : 0,
      duration: Duration(seconds: 2),
      child: GestureDetector(
        onTap: () {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
          setState(() {});
        },
        child: Container(
          color: Colors.grey.withOpacity(0.3),
          child: Center(
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget initPosition() {
    return Positioned(
      right: 40,
      bottom: 40,
      // horizontal_rule
      child: GestureDetector(
          onTap: () {
            isHorizontal = !isHorizontal;

            if (isHorizontal) {
              EntityState.setHorizontal();
            } else {
              EntityState.setVertical();
            }

            setState(() {});
          },
          child: Container(
              width: 100,
              height: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                isHorizontal ? "横屏" : "竖屏",
                style: TextStyle(color: Colors.white),
              ))),
    );
  }

  Widget initPopButton() {
    return Positioned(
      top: 25,
      left: 25,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 100,
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(Icons.keyboard_return,color: Colors.white,),
        ),
      ),
    );
  }
}
