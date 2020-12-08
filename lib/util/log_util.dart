

class LogUtil{

  static bool  isDeBug = true;

  static Log({String tagging,String title}){
    if(isDeBug){
      print("$tagging 为: ${title}");
    }
  }
}