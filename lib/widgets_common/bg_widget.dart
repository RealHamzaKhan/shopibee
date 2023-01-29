import 'package:flutter/cupertino.dart';
import 'package:shopibee/consts/consts.dart';

Widget bgWidget({required Widget child}){
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground),fit: BoxFit.fill),
    ),
    child: child,
  );
}