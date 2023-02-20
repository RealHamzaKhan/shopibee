import 'dart:developer';

import 'package:get/get.dart';
import 'package:shopibee/consts/consts.dart';

class HomeScreenController extends GetxController{
  @override
  void onInit() {
    getUserName();
    // TODO: implement onInit
    super.onInit();
  }
  var navItemIndex=0.obs;
  var username='';
   getUserName()async{
    var n=await firestore.collection(usersCollection).where('id',isEqualTo: user!.uid).get().then((value) {
     if(value.docs.isNotEmpty){
       return value.docs.single['name'];
  }
  });
    username=n as String;
  }
}