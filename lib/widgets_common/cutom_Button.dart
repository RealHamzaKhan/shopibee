import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/auth_controller.dart';
var controller=Get.find<AuthController>();
Widget CustomButton({required VoidCallback onPress,required String title,required Color color}){
  return ElevatedButton(onPressed: onPress,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(12),
      primary: color
    ),
      child:controller.isLoading.value?const CircularProgressIndicator(color: Colors.white,).centered():title.text.make(),
  );
}