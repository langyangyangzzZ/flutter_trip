

class LogUtil{

  static bool  isDeBug = true;

  static Log({String tagging,String title}){
    if(isDeBug){
      print("${tagging??"LogUtil:"} 为: ${title??""}");
    }
  }
}