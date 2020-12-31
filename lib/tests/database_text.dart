import 'package:flutter/material.dart';
import 'package:flutter_trip/util/db_util.dart';
import 'package:flutter_trip/util/toast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

/*
 * @ClassName database_text
 * 作者: szj
 * 时间: 2020/12/29 15:51
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class DBWidget extends StatefulWidget {
  @override
  _DBWidgetState createState() => _DBWidgetState();
}

class _DBWidgetState extends State<DBWidget> {
  String _storageString = "";
  DBUtil _dbUtil;

  @override
  void initState() {
    super.initState();
    _dbUtil = DBUtil.getInstance();
  }

  TextEditingController _textFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _textFieldController,
              onChanged: (value) {
              },
            ),
            ElevatedButton(
              onPressed: () =>
                  _dbUtil.setString(_textFieldController.text.toString()),
              child: Text("存入"),
            ),
            ElevatedButton (
              onPressed: () {
                 setState(()  async{
                     _storageString = await _dbUtil.getString();
                     Toast.toast(context,msg: _storageString);
                });
              },
              child: Text("取出"),
            ),
            Text(_storageString)
          ],
        ),
      ),
    );
  }
}
