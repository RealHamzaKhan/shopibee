import 'package:flutter/cupertino.dart';
import 'package:shopibee/consts/consts.dart';
Widget profileDetails({required String value,required String title}){
  return Column(
    children: [
      value.text.fontFamily(bold).make(),
      5.heightBox,
      title.text.fontFamily(semibold).color(fontGrey).make()
    ],
  ).box.roundedSM.p16.white.make();
}