import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip/beans/home_bean.dart';
import 'package:flutter_trip/util/loading_util.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/web_views/local_nav_web_widget.dart';

class SalesBoxWidget extends StatelessWidget {
  SalesBox _salesBox;

  SalesBoxWidget(this._salesBox);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5,bottom: 5),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
            color: Colors.white
      ),
      child: _buildLayout(context),
    );
  }

  _buildLayout(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: (){
              Navigator.of(context)
                  .push(new MaterialPageRoute(builder: (BuildContext context) {
                return LocalNavWebWidget(
                    _salesBox.moreUrl,"");
              }));
            },
            child: Image.network(
              _salesBox.icon,
              height: 22,
            ),
          )
        ),
        Divider(
          height: 10,
          color: Colors.black45,
        ),
        GridView(
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
              maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
              //水平单个子Widget之间间距
              mainAxisSpacing: 0,
              //垂直单个子Widget之间间距
              crossAxisSpacing: 0),
        )
      ],
    );
  }

  List<Widget> items(BuildContext context) {
    List<Widget> list = [];

    list.add(itemMain(_salesBox.bigCard1,context));
    list.add(itemMain(_salesBox.bigCard2,context));

    list.add(item(_salesBox.smallCard1,context));
    list.add(item(_salesBox.smallCard2,context));
    list.add(item(_salesBox.smallCard3,context));
    list.add(item(_salesBox.smallCard4,context));
    return list;
  }

  item(SmallCard1 smallCard,BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return LocalNavWebWidget(
              smallCard.url,smallCard.title);
        }));
      },
      child: Image.network(
        smallCard.icon,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget itemMain(BigCard1 bigCard, BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.of(context)
            .push(new MaterialPageRoute(builder: (BuildContext context) {
          return LocalNavWebWidget(
              bigCard.url,bigCard.title);
        }));
      },
      child:  Image.network(
        bigCard.icon,
        fit: BoxFit.fill,
      ),
    );
  }
}
