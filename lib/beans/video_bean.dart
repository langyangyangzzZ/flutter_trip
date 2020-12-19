import 'package:flutter/material.dart';
import 'package:flutter_trip/tests/video_page_widget.dart';

/*
 * @ClassName video_bean
 * 作者: szj
 * 时间: 2020/12/18 15:17
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class VideoBean{
  String url;
  //是否播放
  bool ischeck = false;

  int index;

  //播放本地
  VideoPageEnum type = VideoPageEnum.asset;

  VideoBean({@required this.url,this.index, this.ischeck, this.type});
}