import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/video_page_widget/video_item_page_widget.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  //创建一个多订阅流
  final StreamController<VideoPlayerController> _streamController =
      new StreamController.broadcast();

  //播放控制器
  VideoPlayerController _videoPlayerController;

  List<String> _listVideo = [
    "assets/videos/wyy2.mp4",
    "assets/videos/wyy1.mp4",
    "assets/videos/kfc.mp4"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _streamController.stream.listen((event) {
      //当前控制器ID != 传递过来的标识 说明当前传递的是新的标识
      if (_videoPlayerController != null &&
          _videoPlayerController.textureId != event.textureId) {
        _videoPlayerController.pause();
      }
      _videoPlayerController = event;

      LogUtil.Log(
          tagging: "streaminitState",
          title: "接收到消息${_videoPlayerController.textureId}");
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildListView(),
    );
  }

  bool isScroll = false; //是否滑动

  Widget buildListView() {
    /*
      NotificationListener 对ListView滚动监听
     */
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        Type type = notification.runtimeType;

        if (type == ScrollStartNotification) {
          isScroll = true;
          LogUtil.Log(tagging: "buildListView", title: "开始滑动");
        } else if (type == ScrollEndNotification) {
          isScroll = false;
          LogUtil.Log(tagging: "buildListView", title: "停止滑动");
          setState(() {});
        }
        return false;
      },
      child: ListView.builder(
        //不缓存
        cacheExtent: 0,
        //加载20条数据
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return buildListViewItems();
        },
      ),
    );
  }

  Random _random = new Random();

  Widget buildListViewItems() {
    return Container(
      height: 200,
      child: Stack(
        children: [
          Positioned(
            top: 2,
            child: Row(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/flutterandroid1.png",
                    width: 20,
                    height: 20,
                  ),
                  margin: EdgeInsets.only(left: 20),
                ),
                Text(
                  "正在蜕变的CV工程师",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25,left: 20,right: 20),
            child: VideoItemPageWidget(
              url: _listVideo[_random.nextInt(_listVideo.length)],
              isScroll: isScroll,
              streamController: _streamController,
            ),
          ),
        ],
      ),
    );
  }
}
