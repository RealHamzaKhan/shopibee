import 'package:flutter/cupertino.dart';
import 'package:shopibee/consts/consts.dart';

Widget appLogoWidget(){
  return Image.asset(icAppLogo).box.white.size(70, 70).padding(EdgeInsets.all(8)).rounded.make();
}