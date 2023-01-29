import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/auth_controller.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';
import 'package:shopibee/widgets_common/custom_text_field.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';

import '../../controllers/profile_controller.dart';
class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController=Get.put(ProfileController());
    final controller=Get.put(AuthController());
    return bgWidget(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: context.screenHeight*0.1),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body:SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Obx(()=>
                Column(
                  children: [
                    profileController.profileImagePath.isEmpty?
                    Image.asset(imgP1,fit: BoxFit.fill,).box.roundedFull
                    .size(context.screenWidth*0.3,context.screenHeight*0.3)
                    .clip(Clip.antiAlias).make()
                    :Image.file(File(profileController.profileImagePath.value),fit: BoxFit.fill,)
                        .box.roundedFull
                        .size(context.screenWidth*0.3,context.screenHeight*0.3)
                        .clip(Clip.antiAlias).make(),
                    CustomButton(onPress: (){
                      profileController.changeImage(context: context);
                    }, title: 'Pick Image', color: lightGolden),
                    20.heightBox,
                    customTextField(title: "Email", hintText: "demo@gmail.com", controller: controller.emailController),
                    20.heightBox,
                    customTextField(title: "Password", hintText: "*****", controller: controller.passwordController),
                    20.heightBox,
                    CustomButton(onPress: (){}, title: "Save", color: golden),
                  ],
                ),
              ),
            ).paddingSymmetric(horizontal: 30),
          ),
        ).box.white.rounded.outerShadowMd.size(double.infinity, context.screenHeight*0.5).make(),
      ),
    );
  }
}
