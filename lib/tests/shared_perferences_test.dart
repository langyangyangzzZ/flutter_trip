import 'package:flutter/material.dart';
import 'package:flutter_trip/util/sp_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPTest extends StatefulWidget {
  @override
  _SPTestState createState() => _SPTestState();
}

class _SPTestState extends State<SPTest> {
  String TEST_KEY = "test_key";
  String _mObtainData = "";
   final TextEditingController _textcontroller  = TextEditingController();
   bool isUtil = true;//true使用Util false不使用
  @override
  Widget build(BuildContext context) {

    if(isUtil){
      SpUtil.getDate<String>(TEST_KEY).then((value) {
        _mObtainData = value;
        print("存储的值为${value}");
      });
    }else{
      getString(TEST_KEY).then((value) {
        _mObtainData = value;
        print("存储的值为${value}");
      });
    }


    return Column(
      children: [
        SwitchListTile(
          onChanged: (bool value) {
            setState(() {
              isUtil = value;
              print("${isUtil}");
            });
          },
          value: isUtil,//是否选中
          title: Text("是否使用Util类保存数据"),
        ),

        TextField(
          controller: _textcontroller ,
          decoration: InputDecoration(
            hintText: "请输入存储值",
            suffixIcon: IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){
                /**
                 * 刷新Build,重新给下面Text赋值
                 */
                setState(() {
                  if(isUtil){
                    SpUtil.remove(TEST_KEY);
                  }else{
                    //删除sp中保存的文字
                    remove(TEST_KEY);
                  }
                  //删除text上的文字
                  _textcontroller.clear();
                });
              },
            )
          ),
          onChanged: (value) {
            /**
             * 刷新Build,重新给下面Text赋值
             */
            setState(() {
              if(isUtil){
                SpUtil.setData<String>(TEST_KEY, value);
              }else{
                setString(TEST_KEY, value);
              }
            });
          },
        ),
        Text("存储数据为:\n${_mObtainData}",textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
      ],
    );
  }

  void setString(String key, String value) async {
    /**
     * 获取SharedPreferences实例
     */
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString(key, value);
  }

  Future<String> getString(String key) async {
    /**
     * 获取SharedPreferences实例
     */
    SharedPreferences instance = await SharedPreferences.getInstance();
    return instance.get(key);
  }

  /**
   * 删除Key对应的值
   */
  static remove(String key) async{
    SharedPreferences instance= await SharedPreferences.getInstance();
    instance.remove(key);
  }
}
