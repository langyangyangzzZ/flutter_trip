import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/beans/home_bean.dart';
import 'package:flutter_trip/util/loading_util.dart';
import 'package:flutter_trip/web_views/local_nav_web_widget.dart';

class GridNavWidget extends StatelessWidget {
  GridNav gridNav;

  GridNavWidget({this.gridNav});

  @override
  Widget build(BuildContext context) {

      return Padding(
        padding: EdgeInsets.all(5),
        //PhysicalModel裁圆角
        child: PhysicalModel(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          color: Colors.transparent,
          //酒店 机票 旅游
          child: Column(
            children: buildItems(context, gridNav),
          ),
        ),
      );
    }

  /// 酒店
  /// 机票
  /// 旅游
  List<Widget> buildItems(BuildContext context, GridNav gridNav) {
    List<Widget> list = [];
    //酒店
    list.add(item(context, gridNav.hotel,true));

    //机票
    list.add(item(context, gridNav.flight,true));

    //旅游
    list.add(item(context, gridNav.travel,false));

    return list;
  }


  ///isBotton 判断是否向下margin
  Widget item(BuildContext context, Hotel hotel, bool isBotton) {
    Color startColor = Color(int.parse("0xff" + hotel.startColor));
    Color endColor = Color(int.parse("0xff" + hotel.endColor));

    return Container(
      margin: EdgeInsets.only(bottom: isBotton ? 5 : 0),
      height: 80,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //酒店
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext context) {
                return LocalNavWebWidget(
                    gridNav.hotel.mainItem.url, gridNav.hotel.mainItem.title);
              }));
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  hotel.mainItem.title,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                //宽度占满全屏
                Expanded(
                  child: Image.network(
                    hotel.mainItem.icon,
                    fit: BoxFit.fill,
                  ),
                )
              ],
            ),
          )),

          //海外酒店 特价酒店
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //海外酒店
                initItem(hotel.item1.title, context, hotel.item1.url, true,
                    false, true),

                //特价酒店
                initItem(hotel.item2.title, context, hotel.item2.url, false,
                    false, true),
              ],
            ),
          ),

          //团购 民宿客栈
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //海外酒店
                initItem(hotel.item3.title, context, hotel.item3.url, true,
                    false, true),

                //特价酒店
                initItem(hotel.item4.title, context, hotel.item4.url, false,
                    false, true),
              ],
            ),
          )
        ],
      ),
    );
  }

  /// title 对应的名字
  /// isBooton 用来标识线是否画底部的线
  /// context 上下文
  /// url 跳转页面接口
  initItem(title, BuildContext context, String url, bool isBottom, bool isRight,
      bool isLeft) {
    return Expanded(
      child: FractionallySizedBox(
        widthFactor: 1,
        alignment: Alignment.center,
        child: Container(
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (BuildContext context) {
                  return LocalNavWebWidget(url, title);
                }));
              },
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          decoration: BoxDecoration(
              border: Border(
            left: isLeft
                ? BorderSide(color: Colors.white, width: 0.8)
                : BorderSide(width: 0, color: Colors.transparent),
            bottom: isBottom
                ? BorderSide(color: Colors.white, width: 0.8)
                : BorderSide(width: 0, color: Colors.transparent),
            right: isRight
                ? BorderSide(color: Colors.white, width: 0.8)
                : BorderSide(width: 0, color: Colors.transparent),
          )),
        ),
      ),
    );
  }
}
