import 'package:flutter/cupertino.dart';
import 'package:shopibee/consts/consts.dart';

Widget FeaturedButton({required String title,required icon}){
  return Row(
    children: [
      Image.asset(icon,width: 60,fit: BoxFit.fill,),
      10.heightBox,
      title.text.semiBold.size(14).make(),
    ],
  ).box.roundedSM.margin(EdgeInsets.symmetric(horizontal: 5)).padding(EdgeInsets.only(right: 10)).white.make();
}