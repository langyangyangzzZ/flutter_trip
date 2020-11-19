import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _mImageList = [
    "https://image.springup9.com/image/20200805/epcyoisqmm80000000.jpeg",
    "https://image.springup9.com/image/20200805/epcyoisqmm80000000.jpeg",
    "https://image.springup9.com/image/20200805/epcyoisqmm80000000.jpeg",
    "https://image.springup9.com/image/20200805/epcyoisqmm80000000.jpeg",
    "https://image.springup9.com/image/20200805/epcyoisqmm80000000.jpeg"
  ];

  double _mAlpha = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                },
                child: ListView(
                  children: [
                    /**
                     * Bunner
                     */

                    initBanner(),

                    Container(
                      height: 400,
                      color: Colors.yellow,
                    ),
                    Container(
                      height: 400,
                      color: Colors.red,
                    ),
                    Container(
                      height: 400,
                      color: Colors.yellow,
                    )
                  ],
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
        //播放图片长度
        itemCount: _mImageList.length,
        //自动播放
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          //返回播放图片
          return Image.network(
            _mImageList[index],
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
}
