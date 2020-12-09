import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/beans/home_bean.dart';
import 'package:flutter_trip/dao/dao.dart';
import 'package:flutter_trip/home_page_widget/grid_nav_widget.dart';
import 'package:flutter_trip/home_page_widget/local_nav_widget.dart';
import 'package:flutter_trip/home_page_widget/sales_box_widget.dart';
import 'package:flutter_trip/home_page_widget/sub_nav_widget.dart';
import 'package:flutter_trip/util/loading_util.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/web_views/local_nav_web_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///Banner
  List<BannerList> _bannerList = [];

  ///周边游等...
  List<LocalNavList> _localNavList = [];

  ///酒店 机票 旅游 卡片布局
  GridNav _gridNav;

  //wifi电话卡等布局
  List<SubNavList> _subNavList = [];

  //底部卡片布局
  SalesBox _salesBox ;
  double _mAlpha = 0;

  Widget get buildListView {
   return ListView(
      children: [
        ///Bunnear
        initBanner(),

        //攻略景点  周边游 等
        LocalNavWidget(
          localNavList: _localNavList,
        ),

        //卡片布局
        GridNavWidget(
          gridNav: _gridNav,
        ),

        //Wifi电话卡布局
        SubNavWidget(_subNavList),

        //底部卡片布局
        SalesBoxWidget(_salesBox),

      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /**
     * 初始化网络数据
     */
    initData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_bannerList.length == 0 || _localNavList.length == 0 || _subNavList.length == 0 ||
        _salesBox == null || _gridNav == null){
      return LoadingUtil.loading(context,height: double.infinity);
    }
    return Scaffold(
        backgroundColor: Colors.black12,
        /**
         * Stack叠加布局相当于Android中的Fragment
         */
        body: Stack(
          children: [
            /**
             * MediaQuery.removePadding 用来一出顶部的Padding（规范刘海屏）
             */
            MediaQuery.removePadding(
              //MediaQuery必传参数
              context: context,
              //MediaQuery必传参数
              removeTop: true,
              /**
               *NotificationListener用来监听列表的滚动
               */
              child: RefreshIndicator(
                onRefresh: initData,
                child: NotificationListener(
                onNotification: (notification) {
                  /**
                   * notification is ScrollUpdateNotification 判断是否滑动
                   *
                   * notification.depth == 0 只监听第0个元素（防止Bunner，这里的意思是只监听ListView滑动)
                   *
                   */
                  if (notification is ScrollUpdateNotification &&
                      notification.depth == 0) {
                    /**
                     * notification.metrics.pixels 滑动像素
                     *
                     * 因为透明度只接受0和1  0完全透明  1完全不透明  所以/100
                     */
                    double d = notification.metrics.pixels / 100.0;
                    if (d < 0) {
                      d = 0;
                    } else if (d > 1) {
                      d = 1;
                    }
                    setState(() {
                      _mAlpha = d;
                    });
                  }
                  return;
                },
                child: buildListView,
              ),

              ),
            ),
            Opacity(
              opacity: _mAlpha,
              child: Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Text("首页"),
                ),
              ),
            ),
          ],
        ));
  }

  initBanner() {
    return Container(
      height: 200,
      //使用插件  flutter_swiper: ^1.1.6
      child: Swiper(

        onTap: (index){
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) {
          return LocalNavWebWidget(_bannerList[index].url,"");
        }));

      },

        //播放图片长度
        itemCount: _bannerList.length,
        //自动播放
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          //返回播放图片
          return Image.network(
            //因为第三张图片是http的,展示不出来,所以只能换一张图片
            index == 2
                ? "https://pages.ctrip.com/hotel/201811/jdsc_640es_tab1.jpg"
                : _bannerList[index].icon,
            fit: BoxFit.fill,
          );
        },
        //添加轮播图指示器
        /**
         * DotSwiperPaginationBuilder() 左上角显示圆点
         * FractionPaginationBuilder() 左上角显示数字
         * SwiperPagination()           居中小圆点
         *
         */
        pagination: SwiperPagination(),
      ),
    );
  }

  Future<Null> initData() async {
    var dao = new Dao();
    await dao.home_data().then((value) {
      //设置Banner数据
      setState(() {
        _bannerList = value.bannerList;
        _localNavList = value.localNavList;
        _gridNav = value.gridNav;
        _subNavList = value.subNavList;
        _salesBox = value.salesBox;
        print("_gridNav数据为:$_localNavList");
      });
    }).catchError((e) {
      print("首页数据有误:$e");
    });

    return null;
  }

  item(int element) {
    return Container(

      child: Text("$element"),
    );
  }
}
