import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/util/toast.dart';

/*
 * @ClassName cupertino_picker_text
 * 作者: szj
 * 时间: 2020/12/28 17:15
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class CupertinoPickerWidget extends StatefulWidget {
  @override
  _CupertinoPickerWidgetState createState() => _CupertinoPickerWidgetState();
}

class _CupertinoPickerWidgetState extends State<CupertinoPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      itemExtent: 45,
      onSelectedItemChanged: (index) {
        Toast.toast(context, msg: "$index");
      },
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Colors.primaries[1],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        ),
        Container(
          color: Colors.primaries[2],
        ),
        Container(
          color: Colors.primaries[3],
        ),
        Container(
          color: Colors.primaries[4],
        ),
        Container(
          color: Colors.primaries[5],
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.primaries[1],
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
        ),
      ],
    );
  }
}
