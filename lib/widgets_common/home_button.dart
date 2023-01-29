import 'package:flutter/cupertino.dart';
import 'package:shopibee/consts/consts.dart';

Widget Homebutton({required icon,required String title,required height,required width}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 26,),
      10.heightBox,
      title.text.black.align(TextAlign.center).semiBold.size(15).make(),
    ],
  ).box.rounded.white.size(width, height).make();
}