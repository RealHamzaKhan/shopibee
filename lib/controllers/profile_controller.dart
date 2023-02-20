import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:path/path.dart';
class ProfileController extends GetxController{
 var profileImagePath=''.obs;
 final OldpasswordController=TextEditingController();
 final nameController=TextEditingController();
 final newPasswordController=TextEditingController();
 String imageLink='';
 var isUpdated=false.obs;
 changeImage({context})async{
  try{
   final image=await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 70);
   if(image==null){return;}
   profileImagePath.value=image.path;
  }
  catch(e){
   VxToast.show(context, msg: "Unknown error occurred");
  }

 }
 Future<void> uploadProfileImage(context)async{
  try{
   var filename=basename(profileImagePath.value);
   var destination="Images/${auth.currentUser!.uid}/$filename";
   Reference reference=storage.ref().child(destination);
   await reference.putFile(File(profileImagePath.value));
   imageLink=await reference.getDownloadURL();
  }
  catch(e){
   VxToast.show(context, msg: "Unable to upload image");
  }
 }
 updateProfile({required String newName,required String newPass,required String newImage})async{
  // await user!.updateEmail(newEmail);
  // await user!.updatePassword(newPass);
  await firestore.collection('users').doc(user!.uid).update({
   'name':newName,
   'password':newPass,
   'imageUrl':newImage
  });
  isUpdated(false);
 }
 changeAuthPassword({required String email,required String OldPassword,required String newPassword})async{
  final cred=EmailAuthProvider.credential(email: email, password: OldPassword);
  await user!.reauthenticateWithCredential(cred).then((value) {
   user!.updatePassword(newPassword);
  }).catchError((error){
   log('Unable to Update password');
  });
 }
}