import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';

Widget exitDialogue({context}){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.bold.size(18).make(),
        "Do you want to exit the app ?".text.fontFamily(semibold).color(fontGrey).make(),
        20.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(onPress: (){
              SystemNavigator.pop();
            }, title: "Yes", color: Colors.red),
            CustomButton(onPress: (){
              Navigator.pop(context);
            }, title: "No", color: Colors.green),
          ],
        )
      ],
    ).box.p12.make(),
  );
}