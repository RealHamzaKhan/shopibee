import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/firebase_consts.dart';
class AuthController extends GetxController {
  var isLoading=false.obs;
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  Future<UserCredential?> loginMethod(
      {required context}) async {
    UserCredential? userCredential;
    try {
      userCredential =
      await auth.signInWithEmailAndPassword(email: emailController.text,
          password: passwordController.text);
    }
    on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod({
    required String email,
    required String password,
    required context
  }) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }
    on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  storeUserData(
      {required String name, required String password, required String email}) async {
    DocumentReference store = firestore.collection(usersCollection).doc(
        auth.currentUser!.uid);
    store.set({
      'id':auth.currentUser!.uid,
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': ''
    });
  }
  signoutMethod(context)async{
    try{
      await auth.signOut();
    }
    catch(e){
      VxToast.show(context, msg: e.toString());
    }
  }
}