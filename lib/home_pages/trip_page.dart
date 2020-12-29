import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_trip/util/entity_state.dart';
import 'package:image_picker/image_picker.dart';

class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  File _image;
  final picker = ImagePicker();
  List<File> mFlieList = [];

  /// ImageSource.camera 相机拍照
  /// ImageSource.gallery 相册选取图片
  Future getImage(bool bol) async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
        source: bol ? ImageSource.gallery : ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("SZJ本地图片路径为:${_image}");
        mFlieList.add(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mFlieList.length == 0 ? NoContainer() : YesContainer(),
      floatingActionButton: FloatingActionButton(
        onPressed: getPhone,
        tooltip: 'Pick Image',
        child: Icon(
          Icons.add_a_photo,

        ),
        backgroundColor:   EntityState.themeColor,
      ),
    );
  }

  Widget NoContainer() {
    //无选择图片
    return Center(
      child: Text(
        "右下角先选择照片哦(*^▽^*)~",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  //有选择图片
  Widget YesContainer() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      alignment: Alignment.center,
      child: Wrap(
        runSpacing: 5,
        spacing: 10,
        children: initFile(),
      ),
    );
  }

  ///  title 主标题
  ///  bool true相册选取 false拍照选取
  ///  subTitle 副标题
  _item(String title, bool bool, String subTitle) {
    return GestureDetector(
      child: ListTile(
        //背景色
        tileColor: Colors.teal,
        //背景色会把圆角覆盖掉!!
        //副标题
        // subtitle:,

        // 将字体缩小
        // dense: true,

        leading: Icon(
          bool ? Icons.ac_unit_outlined : Icons.add,
          size: 25,
        ),
        //左边显示图片
        // trailing: Icon(Icons.android),

        //末尾显示图片
        contentPadding: EdgeInsets.all(3),
        //内边距 默认16
        title: Text(
          title,
        ),
        onTap: () {
          //短按
          setState(() {
            getImage(bool);
          });
        },
        selected: true,
        //如果选中,则颜色会跟随主题颜色
        enabled: true, //禁止点击事件
      ),
    );
  }

  //底部面板
  void getPhone() {
    showModalBottomSheet(
        // backgroundColor: Colors.tealAccent,
        //点击时底部面板颜色
        // barrierColor: Colors.amber,
        //点击时,底部面板以外的颜色
        shape: RoundedRectangleBorder(
            //设置样式
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        isScrollControlled: false,
        //true 全屏 false 半屏
        isDismissible: true,
        //true外部可以点击  false外部不可以点击
        elevation: 40,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 140,
            child: ListView(
              children: [
                Column(
                  children: [
                    _item("拍照", false, ""),
                    _item("从相册选择", true, ""),
                  ],
                ),
              ],
            ),
          );
        });
  }

  initFile() {
    return mFlieList
        .map((file) => Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.file(
                    file,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.black38),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            mFlieList.remove(file);
                          });
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ))
              ],
            ))
        .toList();
  }
}
