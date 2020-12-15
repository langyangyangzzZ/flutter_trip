import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/util/navigator_util.dart';
import 'package:flutter_trip/util/toast.dart';
import 'package:flutter_trip/web_views/local_nav_web_widget.dart';

/**
 * 富文本页面
 */
class RichTextWidget extends StatefulWidget {
  @override
  _RichTextWidgetState createState() => _RichTextWidgetState();
}

class _RichTextWidgetState extends State<RichTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(new Duration(seconds: 0), () {
      showDialog();
    });
  }

  void showDialog() {
    showCupertinoDialog(
      //必传上下文
      context: context,
      //必传布局
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("温馨提示"),
          content: buildContent(context),
          actions: [
            CupertinoDialogAction(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("确定"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //协议说明文案
  String userPrivateProtocol =
      "我们一向尊重并会严格保护用户在使用本产品时的合法权益（包括用户隐私、用户数据等）不受到任何侵犯。本协议（包括本文最后部分的隐私政策）是用户（包括通过各种合法途径获取到本产品的自然人、法人或其他组织机构，以下简称“用户”或“您”）与我们之间针对本产品相关事项最终的、完整的且排他的协议，并取代、合并之前的当事人之间关于上述事项的讨论和协议。本协议将对用户使用本产品的行为产生法律约束力，您已承诺和保证有权利和能力订立本协议。用户开始使用本产品将视为已经接受本协议，请认真阅读并理解本协议中各种条款，包括免除和限制我们的免责条款和对用户的权利限制（未成年人审阅时应由法定监护人陪同），如果您不能接受本协议中的全部条款，请勿开始使用本产品";

  TapGestureRecognizer _tgr1 = new TapGestureRecognizer();
  TapGestureRecognizer _tgr2 = new TapGestureRecognizer();

  Widget buildContent(BuildContext context) {
    return Container(
      height: 200,
      //ListView可滑动
      child: ListView(
        children: [
          RichText(
            //TextOverflow.ellipsis ...文本
            //TextOverflow.visible  只显示能看到的
            //TextOverflow.clip  减掉溢出文本
            //TextOverflow.fade  将溢出的文本淡入透明。
            overflow: TextOverflow.fade,
            // //设置最大行数
            // maxLines: 5,
            // //对齐属性
            textAlign: TextAlign.right,
            // //文字放大缩小倍数，默认为1.0
            textScaleFactor: 2,
            textDirection: TextDirection.rtl,
            //必传文本
            text: new TextSpan(
                text: "请认真阅读并理解",
                style: TextStyle(color: Colors.grey),
                //手势监听
                // recognizer: ,
                children: [
                  TextSpan(
                      text: "<用户协议>",
                      style: TextStyle(color: Colors.blueAccent),
                      recognizer: _tgr1
                        ..onTap = () {
                          NavigatorUtil.pushPage(
                              context: context,
                              widget: LocalNavWebWidget(
                                  "https://blog.csdn.net/weixin_44819566?spm=1000.2115.3001.5113",
                                  "用户协议"));
                        }),
                  TextSpan(
                    text: "与",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                      text: "<隐私协议>",
                      style: TextStyle(color: Colors.blueAccent),
                      recognizer: _tgr2
                        ..onTap = () {
                          NavigatorUtil.pushPage(
                              context: context,
                              widget: LocalNavWebWidget(
                                  "https://blog.csdn.net/weixin_44819566?spm=1000.2115.3001.5113",
                                  "用户协议"));
                        }),
                  TextSpan(
                    text: userPrivateProtocol,
                    style: TextStyle(color: Colors.grey),
                  )
                ]),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tgr1.dispose();
    _tgr2.dispose();

    super.dispose();
  }
}
