import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
Widget orderStatus({icon,color,title,status}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Container(
        constraints: const BoxConstraints(
          maxHeight: double.infinity,
          maxWidth: double.infinity
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color,width: 4),
        ),
        child: Icon(icon,color: color,size: 32,).paddingAll(5),
      ),
      Expanded(child: Divider(endIndent: 10,indent: 10,color:status? color:Colors.grey,thickness: 2,)),
      SizedBox(
        height: 50,
        width: 170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            '$title'.text.fontFamily(bold).color(status?color:Colors.black).size(18).make(),
            status? Icon(Icons.done_all,color: color,):Container(),
          ],
        ),
      )

    ],
  ).paddingSymmetric(horizontal: 10,vertical: 10);
}