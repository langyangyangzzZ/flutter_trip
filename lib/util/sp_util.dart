import 'package:shared_preferences/shared_preferences.dart'; //依赖地址:https://pub.dev/packages/shared_preferences

/**
 * szj 2020/11/20
 */
class SpUtil {
  /// 通过泛型的形式存储值
  ///    ---------------------------------
  ///    ----------必须写泛型!!!!----------
  ///    ---------------------------------
  static setData<T>(String key, T value) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    switch (T) {
      case String:
        print("SpUtilsetData:T:${T}\t-- key:$key");
        instance.setString(key, value as String);
        break;
      case int:
        instance.setInt(key, value as int);
        break;
      case double:
        instance.setDouble(key, value as double);
        break;
      case bool:
        instance.setBool(key, value as bool);
        break;
    }
  }

  /// 获取存储的值
  ///    ---------------------------------
  ///    ----------必须写泛型!!!!----------
  ///    ---------------------------------
  static Future<T> getDate<T>(String key) async{
    SharedPreferences instance = await SharedPreferences.getInstance();
    var t;
    switch (T) {
      case String:
        print("SpUtilgetData:T:${T}\t-- key:$key");
       t = await instance.getString(key);
        break;
      case int:
        t = instance.getInt(key);
        break;
      case double:
        t = instance.getDouble(key);
        break;
      case bool:
        t = instance.getBool(key);
        break;
    }
    return t;
  }

  /**
   * 存储String类型的List集合
   */
 static setStringList(String key,List<String> value)async{
    SharedPreferences instance= await SharedPreferences.getInstance();
    instance.setStringList(key, value);
  }

  /**
   * 获取存储的String类型List集合
   */
  static Future<List<String>> getStringList(String key) async{
    SharedPreferences instance= await SharedPreferences.getInstance();
   return instance.getStringList(key);
  }

  /**
   * 删除key对应的值
   */
  static remove(String key) async{
    SharedPreferences instance= await SharedPreferences.getInstance();
    instance.remove(key);
  }




}
