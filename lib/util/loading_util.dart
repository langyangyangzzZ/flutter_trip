
import 'package:flutter/material.dart';
import 'package:m_loading/m_loading.dart';


// 依赖: m_loading: ^0.0.1  #loading弹框提示
class LoadingUtil{

 static Widget  loading(BuildContext context,{double height}){
   return  Container(
        width: double.infinity,
        alignment: Alignment.center,
           height: height??100 ,
           child: SquareGridScaleLoading(
             color: Colors.lightBlue,
           ),
       );
 }
}