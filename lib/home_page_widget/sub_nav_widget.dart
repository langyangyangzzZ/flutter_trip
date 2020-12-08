import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/beans/home_bean.dart';
import 'package:flutter_trip/util/loading_util.dart';
import 'package:flutter_trip/web_views/local_nav_web_widget.dart';

class SubNavWidget extends StatelessWidget {
  List<SubNavList> subNavList;

  SubNavWidget(this.subNavList);

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(left: 5,right: 5,bottom: 5),
      child: _buildLayout(context),
    );
  }

  ///主布局
  Widget _buildLayout(BuildContext context) {
    return GridView(
      //禁用滑动属性 否则与HomePage滑动冲突
      physics: new NeverScrollableScrollPhysics(),
      //滑动方向
      scrollDirection: Axis.vertical,
      //子Widget
      children: items(context),
      //反转 最好是占盘全屏使用
      // reverse: true,
      shrinkWrap: true,
      //垂直时显示的子Widget高度 水平时显示的子Widget宽度
      // itemExtent: 100,
      //GridView边距
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //单个子Widget的水平最大宽度
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 5,
          //水平单个子Widget之间间距
          mainAxisSpacing: 10.0,
          //垂直单个子Widget之间间距
          crossAxisSpacing: 10),
    );
  }

  List<Widget> items(BuildContext context) {
    List<Widget> list = [];
    subNavList.forEach((element) {
      list.add(item(element,context));
    });
    return list;
  }

  Widget item(SubNavList element, BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){
          Navigator.of(context)
              .push(new MaterialPageRoute(builder: (BuildContext context) {
            return LocalNavWebWidget(
                element.url,element.title);
          }));
        },
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                element.icon,
                width: 24,
                height: 24,
              ),
            ),
            Center(
              child: Text(
                element.title,
                style: TextStyle(fontSize: 10, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
