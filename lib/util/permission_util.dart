
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

/**
 * @ClassName ${NAME}
 * 作者: szj
 * 时间: ${DATE} ${TIME}
 * CSDN:https://blog.csdn.net/weixin_44819566
 * 公众号:码上变有钱
 */

class PermissionUtil  {


  PermissionUtil(this._context);

  List<String> _list = [
    "为了更好地应用体验,请确定权限",
    "您第一次拒绝权限,请确定权限",
    "您第二次拒绝权限,请去应用市场开启权限"
  ];

  BuildContext _context ;

  void checkPermission({PermissionStatus status}) async {
    //申请权限     permission_handler: ^5.0.1+1

    //外部存储权限
    Permission permission = Permission.storage;

    if (status == null) {
      ///权限状态
      status = await permission.status;
    }

    if (status.isUndetermined) {
      //第一次申请
      showPermissionDialog(_list[0], "同意", permission);
    } else if (status.isDenied) {
      //第一次申请拒绝
      showPermissionDialog(_list[1], "重试", permission);
    } else if (status.isPermanentlyDenied) {
      //第二次申请
      showPermissionDialog(_list[2], "去应用市场", permission,isUndetermined: true);
    } else {
      //通过
    }
  }

  ///是否去设置中心
  bool isGoAppSetteng = false;

  ///msg 提示文案
  ///rightMsg  右侧按钮显示文案
  ///要申请的权限
  /// isUndetermined 可选参数,传入的是当前是否去设置中心
  void showPermissionDialog(
      String msg, String rightMsg, Permission permission,{bool isUndetermined = false}) {
    //使用苹果的dialog
    showCupertinoDialog(
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text("温馨提示"),
            content: Container(
              child: Text(msg),
            ),
            actions: [
              //左边按钮
              CupertinoDialogAction(
                child: Text("关闭应用"),
                onPressed: (){
                  //关闭引用
                  closeAPP();
                },
              ),
              //右边
              CupertinoDialogAction(
                child: Text(rightMsg),
                onPressed: () {

                  //关闭弹框
                  Navigator.pop(context);
                  if(isUndetermined){
                    isGoAppSetteng = true;
                    //去设置中心
                    openAppSettings();
                  }else{
                    //申请权限
                    isGoAppSetteng = false;
                    requestPermission(context,permission);
                  }


                },
              ),
            ],
          );
        },
        context: _context);
  }

  void requestPermission(BuildContext context,Permission permission) async {

      //请求权限
      PermissionStatus status = await permission.request();

      //校验
      checkPermission(status: status);

  }
//关闭应用
  void closeAPP() {
    SystemChannels.platform.invokeMethod("SystemNavigator.pop");
  }


}