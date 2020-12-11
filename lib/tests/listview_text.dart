import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_trip/beans/listview_bean.dart';
import 'package:flutter_trip/util/loading_util.dart';
import 'package:flutter_trip/util/log_util.dart';
import 'package:flutter_trip/util/toast.dart';

class ListViewTextWidget extends StatefulWidget {
  @override
  _ListViewTextWidgetState createState() => _ListViewTextWidgetState();
}

class _ListViewTextWidgetState extends State<ListViewTextWidget> {
  List<ListViewBean> _list = [];

  List<String> _lsitcheck = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i <= 100; i++) {
      _list.add(new ListViewBean(false, "$i"));
    }
  }

  int _type = 0;

  List<Widget> initData() {
    List<Widget> mlist = [];

    mlist.add(initButton("单选", 1));
    mlist.add(initButton("多选", 2));
    mlist.add(initButton("全选", 3));

    _list.forEach((e) => {
          mlist.add(
            isLoadingImage
                ? buildItem(e)
                :
                //滑动时显示的LoadingUtil
                Container(
                    alignment: Alignment.center,
                    child: LoadingUtil.loading(context),
                  ),
          )
        });
    return mlist;
  }

  bool isLoadingImage = true; //是否滑动

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NotificationListener(
          child: Container(
            child: _buildListView(),
          ),
          onNotification: (notification) {
            ///通知类型
            switch (notification.runtimeType) {
              case ScrollStartNotification:
                print("开始滚动");

                ///在这里更新标识 刷新页面 不加载图片
                isLoadingImage = false;
                break;
              case ScrollUpdateNotification:
                print("正在滚动");
                break;
              case ScrollEndNotification:
                print("滚动停止");

                ///在这里更新标识 刷新页面 加载图片
                setState(() {
                  isLoadingImage = true;
                });
                break;
              case OverscrollNotification:
                print("滚动到边界");
                break;
            }
            return true;
          },
        ),
      ),
    );
  }

  ScrollController scrollController = ScrollController();


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget _buildListView() {
      scrollController.addListener(() {
      ///scrollController.position.maxScrollExtent  ListView滑动的最大距离
      ///scrollController.position.pixels  现在滑动的距离
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        LogUtil.Log(
            tagging: "scrollController:",
            title:
                "pixels:${scrollController.position.pixels}maxScrollExtent:${scrollController.position.maxScrollExtent}");
      }
    });
    return ListView(
      //滑动方向
      scrollDirection: Axis.vertical,

      //当scrollDirection = Axis.vertical  itemExtent代表的是高度
      //当scrollDirection = Axis.horizontal  itemExtent代表的是宽度
      itemExtent: 50,

      //内边距
      padding: EdgeInsets.only(left: 10, right: 10, top: 30),

      //当条目不足时 true可以尝试滚动  false不可以滚动
      primary: false,

      physics: ClampingScrollPhysics(),
      ///BouncingScrollPhysics 拉到ListView最底部有回弹效果
      ///NeverScrollableScrollPhysics 滑动禁止
      ///ClampingScrollPhysics  包裹内容不会回弹

      // 预加载区域
      cacheExtent: 0.0,

      //是否倒序显示 默认正序 false  倒序true
      reverse: false,
      ///使用ScrollController scrollController = ScrollController();
      ///对ListView监听,多用于监听是否滚动到底部
      controller: scrollController,

      //子Widget
      children: initData(),
    );
  }

  initButton(String title, int type) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          //将所有的默认为为收藏
          _list.forEach((element) {
            element.ischeck = false;
          });

          _type = type;
        });
      },
      child: Text(title),
    );
  }

  ///[e] 当前的Widget
  Widget buildItem(ListViewBean e) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.lightBlueAccent,width: 0.5)
        )
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Text("第${e.title}个元素"),
          ),
          RaisedButton(
            color: e.ischeck ? Colors.black : Colors.red,
            onPressed: () {
              setState(() {
                if (_type == 1) {
                  //单选
                  initSingleChoice(e);

                } else if (_type == 2) {
                  //多选
                  initMultipleChoice(e);
                } else {
                  //全选
                  _list.forEach((element) {
                    e.ischeck = element.ischeck = !element.ischeck;
                  });
                }
              });
            },
            child: Text(
              e.ischeck ? "已收藏" : "未收藏",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  //单选
  void initSingleChoice(ListViewBean e) {
    //单选
    e.ischeck = !e.ischeck;
    _list.forEach((element) {
      //若当前有选中的按钮
      if (element.ischeck == e.ischeck && e.ischeck == true) {
        print("SZJischeck${element.ischeck }title:${element.title}");
        //无论有没有选中 都将改成未选中
        element.ischeck = false;
        //选中
        e.ischeck = true;

        Toast.toast(context, msg: e.title);
      }
    });
  }

  //多选
  void initMultipleChoice(ListViewBean e) {
    //多选
    if (!e.ischeck) {
      _lsitcheck.add("${e.title}");
    } else {
      _lsitcheck.remove("${e.title}");
    }
    Toast.toast(context, msg: "${_lsitcheck.toString()}");

    e.ischeck = !e.ischeck;
  }
}
