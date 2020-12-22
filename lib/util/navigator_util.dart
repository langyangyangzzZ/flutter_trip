import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/util/log_util.dart';

class NavigatorUtil {
  ///[buildContext] 必传上下文
  ///[widget] 跳转页面
  ///[isReplace] 是否替换当前页面 A -> B B - C 替换掉B之后 A -> C
  static void pushPage({
    @required BuildContext context,
    @required Widget widget,
    bool isReplace = false,
    Function(dynamic value) dismissCallBack,
  }) {
    PageRoute pageRoute = MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    });
    //替换当前页面
    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      //普通跳转
      Navigator.of(context).push(pageRoute).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }

  //跳转并关闭销毁当前页面  常用于引导页面
  ///[context] 必传上下文
  ///[widget] 要跳转的页面
  static void pushColsePage({
    @required BuildContext context,
    @required Widget widget,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      new MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => route == null,
    );
  }

  ///[buildContext] 必传上下文
  ///[widget] 跳转页面
  ///[isOpaque] 是否以透明的方式打开
  ///[isReplace] 是否替换当前页面 A -> B B - C 替换掉B之后 A -> C
  static void pushPageByFade({
    @required BuildContext context,
    @required Widget widget,
    bool isOpaque = false,
    bool isReplace = false,
    Function(dynamic value) dismissCallBack,
  }) {
    LogUtil.Log(tagging: "isOpaque", title: "$isOpaque");
    PageRoute pageRouteBuilder = new PageRouteBuilder(
        opaque: isOpaque,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget;
        },
        //过度动画
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          //透明渐变
          return FadeTransition(
            //渐变
            opacity: secondaryAnimation,
            child: child,
          );
        });

    //替换当前页面
    if (isReplace) {
      Navigator.of(context).pushReplacement(pageRouteBuilder).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    } else {
      //普通跳转
      Navigator.of(context).push(pageRouteBuilder).then((value) {
        if (dismissCallBack != null) {
          dismissCallBack(value);
        }
      });
    }
  }
}
