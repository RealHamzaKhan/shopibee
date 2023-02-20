import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/auth_controller.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';
import 'package:shopibee/widgets_common/custom_text_field.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';

import '../../controllers/profile_controller.dart';
class EditProfile extends StatelessWidget {
  dynamic data;
   EditProfile({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController=Get.put(ProfileController());
    final controller=Get.put(AuthController());
    return bgWidget(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: context.screenHeight*0.05),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body:SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Obx(()=>
                Column(
                  children: [
                   data['imageUrl']=='' && profileController.profileImagePath.isEmpty?
                    Image.asset(imgP1,fit: BoxFit.fill,).box.roundedFull
                    .size(context.screenWidth*0.3,context.screenHeight*0.3)
                    .clip(Clip.antiAlias).make()
                   :profileController.profileImagePath.isNotEmpty?
                  Image.file(File(profileController.profileImagePath.value),fit: BoxFit.fill,)
                .box.roundedFull
                .size(context.screenWidth*0.3,context.screenHeight*0.3)
                .clip(Clip.antiAlias).make()
                    :Image.network(data['imageUrl']).box.roundedFull
                       .size(context.screenWidth*0.3,context.screenHeight*0.3)
                       .clip(Clip.antiAlias).make(),
                    CustomButton(onPress: (){
                      profileController.changeImage(context: context);
                    }, title: 'Pick Image', color: lightGolden),
                    20.heightBox,
                    customTextField(title: "Name", hintText: "", controller: profileController.nameController),
                    20.heightBox,
                    customTextField(title: "Old Password", hintText: "*****", controller: profileController.OldpasswordController,isPassword: true),
                    20.heightBox,
                    customTextField(title: "New Password", hintText: "*****", controller: profileController.newPasswordController,isPassword: true),
                    20.heightBox,
                    profileController.isUpdated.value?const CircularProgressIndicator(color: Colors.black,):
                    CustomButton(onPress: ()async{
                      profileController.isUpdated.value=true;
                      if(profileController.profileImagePath.value.isNotEmpty){
                        try{
                          if(profileController.OldpasswordController.text==data['password']){
                            await profileController.uploadProfileImage(context);
                            await profileController.changeAuthPassword(email: data['email'],
                                OldPassword: profileController.OldpasswordController.text,
                                newPassword: profileController.newPasswordController.text);
                            await profileController.updateProfile(newName: profileController.nameController.text,
                              newPass: profileController.newPasswordController.text,
                              newImage: profileController.imageLink,
                            );
                            VxToast.show(context, msg: 'Profile Updated Successfully');
                          }
                          else{
                            VxToast.show(context, msg: "Wrong Old Password");
                          }
                        }
                        catch(e){
                          VxToast.show(context, msg: "Unable to update profile kindly try later");

                        }
                        profileController.isUpdated.value=false;
                      }
                      else{
                        try{
                          if(profileController.OldpasswordController.text==data['password']) {
                            await profileController.changeAuthPassword(email: data['email'],
                                OldPassword: profileController.OldpasswordController.text,
                                newPassword: profileController.newPasswordController.text);
                            await profileController.updateProfile(
                              newName: profileController.nameController.text,
                              newPass: profileController.newPasswordController.text,
                              newImage: data['imageUrl'],

                            );
                            VxToast.show(context, msg: 'Profile Updated Successfully');
                          }
                          else{
                            VxToast.show(context, msg: "Wrong Old Password");
                          }
                          controller.isLoading.value=false;
                        }
                        catch(e){
                          VxToast.show(context, msg: "Unable to update profile kindly try later");
                          controller.isLoading.value=false;
                        }
                        profileController.isUpdated.value=false;
                      }

                    }, title: "Save", color: golden).box.width(double.infinity).make(),
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
