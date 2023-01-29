import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';

Widget customTextField({required String title,required String hintText,required controller,bool isPassword=false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.semiBold.size(16).color(redColor).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration:InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey
          ),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor)
          )
        ),
      ),
      10.heightBox,
    ],
  );
}