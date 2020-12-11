import 'package:flutter/material.dart';
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

    for (int i = 0; i <= 20; i++) {
      _list.add(new ListViewBean(false, "$i"));
    }
  }

  List<Widget> initData() {
    List<Widget> mlist = [];
    _list.forEach((e) => {
          mlist.add(
            isLoadingImage
                ? Container(
                    height: 100,
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

                              _list.forEach((element) {
                                e.ischeck  =   element.ischeck =  !element.ischeck;
                              });

                              // //多选
                              // if (!e.ischeck) {
                              //   _lsitcheck.add("${e.title}");
                              // } else {
                              //   _lsitcheck.remove("${e.title}");
                              // }
                              // Toast.toast(context,
                              //     msg: "${_lsitcheck.toString()}");
                              //
                              // e.ischeck = !e.ischeck;
                            });
                          },
                          child: Text(
                            e.ischeck ? "已收藏" :"未收藏",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: LoadingUtil.loading(context),
                  ),
          )
        });
    return mlist;
  }

  bool isLoadingImage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: NotificationListener(
          child: _buildListView(),
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

  Widget _buildListView() {
    return ListView(
      children: initData(),
    );
  }
}
