import 'package:flutter/material.dart';
import 'package:flutter_trip/util/toast.dart';

/*
 * @ClassName show_popup_text
 * 作者: szj
 * 时间: 2020/12/23 15:20
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class ShowPopupWidget extends StatefulWidget {
  @override
  _ShowPopupWidgetState createState() => _ShowPopupWidgetState();
}

class _ShowPopupWidgetState extends State<ShowPopupWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            initPopupMenuButton(),

            initSnackBar(),

            // initSnackBar(context),
          ],
        ),
      ),
    );
  }

  Widget initPopupMenuButton() {
    return PopupMenuButton(
      //不能和child同时存在~!!!
      // icon: Icon(Icons.android),

      //不能和Icon同时存在~!!!
      child: Text("PopupMenuButton按钮"),
      //圆形矩形边框
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30), topRight: Radius.circular(30))),

      //偏移
      offset: Offset(0, 10),

      //点击弹框外部
      onCanceled: () {
        Toast.toast(context, msg: "点击了弹框外部");
      },

      // 选中内容
      onSelected: (s) {
        Toast.toast(context, msg: "onSelected:$s");
      },

      tooltip: "123",

      //聚焦(是否可点击)
      enabled: true,

      //弹框阴影
      elevation: 20,

      //背景颜色
      color: Colors.blue.withOpacity(0.5),

      //必传参数
      itemBuilder: (BuildContext context) => [
        initItem("选项一"),
        initItem("选项二"),
        initItem("选项三"),
      ],
    );
  }

  PopupMenuItem initItem(String title) {
    return new PopupMenuItem(
        //用来回调 onSelected 内容
        value: title,
        child: Text(title,style: TextStyle(color: Colors.white),));
  }

  SnackBar buildSnackBar() {
    return SnackBar(
      //背景颜色
      backgroundColor: Colors.red,

      elevation: 30,

      //弹出样式 SnackBarBehavior.floating悬浮弹出
      //        SnackBarBehavior.fixed底部弹出
      behavior: SnackBarBehavior.floating,

      //SnackBar弹出时调用
      onVisible: (){
        Toast.toast(context,msg: "SnackBar已弹出");
      },

      //按钮颜色
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      //提示文字
      content: Text("您有一条未读消息.."),

      //显示时间 默认4s
      duration: Duration(seconds: 2),

      //确定按钮
      action: SnackBarAction(
        onPressed: () {
          Toast.toast(context, msg: "SnackBar确定");
        },
        label: '确定',
        textColor: Colors.white,
      ),
    );
  }

  ///SnackBar
 Widget initSnackBar() {
    return   Builder(
      builder: (BuildContext context) {
        return RaisedButton(
          onPressed: () {
            SnackBar _snackBar = buildSnackBar();

            Scaffold.of(context).showSnackBar(_snackBar);
          },
          child: Text("显示SnackBar"),
        );
      },
    );
  }
}
