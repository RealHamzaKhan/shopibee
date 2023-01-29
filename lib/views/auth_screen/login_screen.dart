import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/controllers/auth_controller.dart';
import 'package:shopibee/views/auth_screen/signup_screen.dart';
import 'package:shopibee/views/home_screen/home.dart';
import 'package:shopibee/widgets_common/app_logo_widget.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';
import 'package:shopibee/widgets_common/custom_text_field.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            'Login to $appname'.text.semiBold.white.size(15).make(),
            10.heightBox,
            Column(
              children: [
                customTextField(title: email, hintText: emailHintText,controller: controller.emailController),
                customTextField(title: password, hintText: passwordHintText,controller: controller.passwordController,isPassword:true),
                Align(
                    alignment: Alignment.centerRight,
                    child: forgetPassword.text.semiBold.red500.make()),
                10.heightBox,
                Obx(()=>
                   CustomButton(onPress: () async{
                     controller.isLoading.value=true;
                    try{
                      await controller.loginMethod( context: context).then((value) {
                        if(value!=null){
                          Get.offAll(()=>const Home());
                        }

                      });
                    }
                    catch(e){
                      VxToast.show(context, msg: e.toString());
                    }
                     controller.isLoading.value=false;
                  }, title: login, color: redColor)
                      .box
                      .width(context.screenWidth - 20)
                      .make(),
                ),
                5.heightBox,
                "or $createNewAccount".text.gray400.medium.make(),
                5.heightBox,
                CustomButton(
                    onPress: () {
                      Get.to(()=>const SignUpScreen());
                    }, title: createNewAccount, color: lightGolden).box
                    .width(context.screenWidth-20).make(),
                5.heightBox,
                "Or Login with".text.gray400.medium.make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage(socialIconsList[index]),
                        backgroundColor: Colors.white,
                      ),
                    );
                  }),
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70).shadowLg
                .make(),
          ],
        ),
      ),
    ));
  }
}
