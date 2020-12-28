

class LogUtil{

  static bool  isDeBug = true;

  // ignore: non_constant_identifier_names
  static void Log({String tagging,String title}){
    if(isDeBug){
      print("${tagging!= null? tagging : "LogUtil:"} 为: ${title ==null ?"报空了!!!!" :title}");
    }
  }

  static LogI(String title , {String tagging}){
    if(isDeBug){
      print("${tagging!= null? tagging : "LogUtil:"} 为: ${title ==null ?"报空了!!!!" :title}");
    }
  }
}