import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';

import '../../../consts/colors.dart';
import 'package:intl/intl.dart' as intl;
Widget senderBubble({required DocumentSnapshot data,required bool isSender}){
  var t=data['created_on']==null?DateTime.now():data['created_on'].toDate();
  var time=intl.DateFormat("h:ma").format(t);
  return Container(
    padding: const EdgeInsets.all(10),
    constraints: const BoxConstraints(
      maxWidth: double.infinity,
    ),
    decoration: BoxDecoration(
        borderRadius: isSender?const BorderRadius.only(topRight: Radius.circular(10),
          topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),
        ):const BorderRadius.only(topRight: Radius.circular(10),
          topLeft: Radius.circular(10),bottomRight: Radius.circular(10),
        ),
        color: isSender?darkFontGrey:redColor
    ),
    child: Column(
      crossAxisAlignment: isSender?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        "${data['message']}".text.color(whiteColor).size(16).make(),
        10.heightBox,
        time.text.size(13).color(whiteColor.withOpacity(0.5)).make()
      ],
    ),
  ).marginOnly(bottom: 5);
}