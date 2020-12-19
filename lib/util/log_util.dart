

class LogUtil{

  static bool  isDeBug = true;

  // ignore: non_constant_identifier_names
  static Log({String tagging,String title}){
    if(isDeBug){
      print("${tagging!= null? tagging : "LogUtil:"} 为: ${title ==null ?"报空了!!!!" :title}");
    }
  }
}