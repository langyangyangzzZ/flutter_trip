import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/tests/b_test.dart';
import 'package:flutter_trip/util/navigator_util.dart';

class AText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ElevatedButton(
            onPressed: () {
              NavigatorUtil.pushPage(context: context, widget: BText());
            },
            child: Text("A页面(pushPage)"),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            builderDialog(context);
          },
          child: Text("A页面(pushPageByFade)"),
        )
      ],
    );
  }

  void builderDialog(BuildContext context) {
    ///苹果效果的Dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text("温馨提示"),
          content: Text("温馨提示内容..."),
          actions: [
            CupertinoDialogAction(
            onPressed: (){
              Navigator.of(context).pop();
            },
              child: Text("关闭"),
            ),
            CupertinoDialogAction(
              onPressed: (){
                Navigator.of(context).pop();
                NavigatorUtil.pushPageByFade(
                    context: context, widget: BText(), isOpaque: true,isReplace: true);
              },
              child: Text("跳转B页面"),
            ),
          ],
        );
      },
    );
  }
}
