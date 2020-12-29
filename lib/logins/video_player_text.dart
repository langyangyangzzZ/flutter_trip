import 'package:flutter/material.dart';
import 'package:flutter_trip/logins/video_page_widget.dart';
import 'package:video_player/video_player.dart';

/// 1217
/// szj
/// 公众号:码上变有钱
/// 微信号:ohhzzZ77
/// CSDN:https://blog.csdn.net/weixin_44819566
/// video_player: ^1.0.1 # 视屏播放   https://pub.dev/packages/video_player/install
class VideoPlayerWidget extends StatefulWidget {
  String url;

  ///VideoPageEnum.asset 本地视屏  默认
  /// VideoPageEnum.network 网络视频
  VideoPageEnum type;

  VideoPlayerWidget({@required this.url, this.type  = VideoPageEnum.asset});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    widget.type == VideoPageEnum.asset
        ? VideoPlayerController.asset(widget.url)
        : VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    _controller.play();
  }

  // _controller.play();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
