import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/home_screen_controller.dart';

class ChatController extends GetxController{
  @override
  void onInit() {
    getChatId();
    // TODO: implement onInit
    super.onInit();
  }
  var chats=firestore.collection(chatsCollection);
  var friendId=Get.arguments[0];
  var friendName=Get.arguments[1];
  var userId=user!.uid;
  var userName=Get.put(HomeScreenController()).username;
  var messageController=TextEditingController();
  dynamic chatDocId;
  var isLoading=true.obs;
  getChatId()async{
    await chats.where('users',isEqualTo:{friendId:null,userId:null}).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocId=snapshot.docs.single.id;
      }
      else{
        chats.add({
          'created_on':null,
          'last_message':'',
          'users':{friendId:null,userId:null},
          'to_id':'',
          'from_id':'',
          'friend_name':friendName,
          'sender_name':userName
        }).then((value) {
          chatDocId=value.id;
        });
      }
    });
    isLoading(false);
  }
  sendMsg({required String msg})async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update({
        'created_on':FieldValue.serverTimestamp(),
        'last_message':msg,
        'to_id':friendId,
        'from_id':userId,
      });
      chats.doc(chatDocId).collection(messageCollection).doc().set({
        'created_on':FieldValue.serverTimestamp(),
        'message':msg,
        'uid':userId,
      });
    }
  }
}