import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/colors.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/views/auth_screen/login_screen.dart';
import 'package:shopibee/views/home_screen/Home_Screen.dart';
import 'package:shopibee/views/home_screen/home.dart';
import 'package:shopibee/widgets_common/app_logo_widget.dart';
import 'package:get/get.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
      auth.authStateChanges().listen((User? user) {
        if(user==null && mounted){
          Get.to(()=>const LoginScreen());
        }
        else{
          Get.to(()=>const Home());
        }
      });
    });
  }
  @override
  void initState() {
    changeScreen();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(alignment:Alignment.topLeft,child: Image.asset(icSplashBg,width:300,)),
            20.heightBox,
            appLogoWidget(),
            10.heightBox,
            appname.text.white.size(20).make(),
            10.heightBox,
            appversion.text.white.size(10).make(),
            const Spacer(),
            credits.text.white.medium.size(15).make(),
            30.heightBox
          ],
        ),
      ),
    );
  }
}
