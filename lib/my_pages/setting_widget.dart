import 'package:flutter/material.dart';
import 'package:flutter_trip/util/entity_state.dart';
import 'package:flutter_trip/util/providers.dart';
import 'package:flutter_trip/util/sp_util.dart';
import 'package:flutter_trip/util/toast.dart';
import 'package:provider/provider.dart';

/*
 * @ClassName setting_widget
 * 作者: szj
 * 时间: 2020/12/26 10:28
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */
class SettingWidget extends StatefulWidget {
  @override
  _SettingWidgetState createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  //夜间模式
  bool isNight = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //判断当前是否是夜间模式
    Provider.of<AppInfoProvider>(context, listen: false)?.themeMode == "dark"
        ? isNight = true
        : isNight = false;
  }

  String _colorKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        child: ListView(
          children: [
            //夜间模式
            initSwitchListTile(context),
            //颜色主题
            initExpansionTile(),
          ],
        ),
      ),
    );
  }

  //夜间模式
  SwitchListTile initSwitchListTile(BuildContext context) {
    return SwitchListTile(
      title: Text("夜间模式${isNight ? "已开启" : "未开启"}"),
      //按钮打开颜色
      activeColor: EntityState.ThemeColor,
      onChanged: (bool value) {
        setState(() {
          isNight = value;
          //改变主题模式
          Provider.of<AppInfoProvider>(context, listen: false)
              .setNight(value ? "dark" : "light");

          Toast.toast(context, msg: "$value");
        });
      },
      value: isNight,
    );
  }

  String getValue(bool value) => value ? "dark" : "light";

  //颜色主题
  Widget initExpansionTile() {
    return ExpansionTile(
      //主题
      leading: Icon(
        Icons.colorize,
        color: EntityState.ThemeColor,
      ),
      title: Text(
        '颜色主题',
        style: TextStyle(color:EntityState.ThemeColor),
      ),
      initiallyExpanded: true,
      trailing: Icon(
        Icons.expand_more,
        color: EntityState.ThemeColor,
      ),
       //展开关闭监听
       onExpansionChanged: (v){
        Toast.toast(context,msg: v.toString());
       },
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          //设置颜色布局
          child: initWrap(),
        )
      ],
    );
  }

  Wrap initWrap() {
    return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: EntityState.themeColorMap.keys.map((key) {
            Color value = EntityState.themeColorMap[key];
            return InkWell(
              onTap: () {
                Provider.of<AppInfoProvider>(context, listen: false)
                    .setTheme(key);
                setState(() {
                  //保存默认颜色
                  EntityState.ThemeColor = EntityState.themeColorMap[key];

                  _colorKey = key;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                color: value,
                child: _colorKey == key
                    ? Icon(
                        Icons.done,
                        color: Colors.white,
                      )
                    : null,
              ),
            );
          }).toList(),
        );
  }
}
