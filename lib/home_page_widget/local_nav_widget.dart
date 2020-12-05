import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/beans/home_bean.dart';
import 'package:flutter_trip/util/toast.dart';
import 'package:flutter_trip/web_views/local_nav_web_widget.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class LocalNavWidget extends StatelessWidget {
  final List<LocalNavList> localNavList;

  LocalNavWidget({Key key, @required this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        ///每个子组件左右间隔相等，也就是 margin 相等。
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: item(context),
      ),
    );
  }

  List<Widget> item(BuildContext context) {
    List<Widget> list = [];
    localNavList.forEach((element) {
      list.add(item2(element, context));
    });
    return list;
  }

  Widget item2(LocalNavList element, BuildContext context) {
    return InkWell(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            element.icon,
            width: 32,
            height: 32,
          ),
          Text(element.title)
        ],
      ),
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
          return LocalNavWebWidget(element.url,element.title);
        }));
        Toast.toast(context,
            msg: "${element.title}", position: ToastPostion.bottom);
      },
    );
  }
}
