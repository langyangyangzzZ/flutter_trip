import 'package:flutter/material.dart';
import 'package:flutter_trip/tests/c_test.dart';
import 'package:flutter_trip/util/navigator_util.dart';

class BText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //当前为B页面
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                NavigatorUtil.pushPage(
                    context: context, widget: CText(), isReplace: true);
              },
              child: Text("B页面"),
            ),
          ),

          //销毁当前页面
          ElevatedButton(
            onPressed: () {
              NavigatorUtil.pushColsePage(context: context, widget: CText());
            },
            child: Text("销毁当前页面并跳转到C页面"),
          ),
        ],
      ),
    );
  }
}
