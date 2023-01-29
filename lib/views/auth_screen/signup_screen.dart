import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/views/home_screen/home.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets_common/app_logo_widget.dart';
import '../../widgets_common/bg_widget.dart';
import '../../widgets_common/custom_text_field.dart';
import '../../widgets_common/cutom_Button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final controller = Get.put(AuthController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRetypeController = TextEditingController();
  bool _isCheck = false;
  @override
  void dispose() {
    controller.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetypeController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            'Get Started with $appname'.text.semiBold.white.size(15).make(),
            10.heightBox,
            Column(
              children: [
                customTextField(
                    title: name,
                    hintText: nameHintText,
                    controller: nameController),
                customTextField(
                    title: email,
                    hintText: emailHintText,
                    controller: emailController),
                customTextField(
                    title: password,
                    hintText: passwordHintText,
                    controller: passwordController,
                    isPassword: true),
                customTextField(
                    title: retypePassword,
                    hintText: retypePasswordHintText,
                    controller: passwordRetypeController,
                    isPassword: true),
                10.heightBox,
                Row(
                  children: [
                    Checkbox(
                        activeColor: redColor,
                        value: _isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            _isCheck = newValue!;
                          });
                        }),
                    Expanded(
                      child: RichText(
                          text: const TextSpan(children: [
                        TextSpan(
                          text: 'I agree to ',
                          style: TextStyle(color: fontGrey, fontFamily: bold),
                        ),
                        TextSpan(
                            text: "$privacyAndPolicy & ",
                            style:
                                TextStyle(fontFamily: bold, color: redColor)),
                        TextSpan(
                            text: termsAndConditions,
                            style:
                                TextStyle(fontFamily: bold, color: redColor)),
                      ])),
                    )
                  ],
                ),
                5.heightBox,
                Obx(()=>
                   CustomButton(
                          onPress: () async {
                            if (_isCheck != false) {
                              try {
                                controller.isLoading.value=true;
                                controller
                                    .signupMethod(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context)
                                    .then((value) {
                                  return controller.storeUserData(
                                      name: nameController.text,
                                      password: passwordController.text,
                                      email: emailController.text);
                                }).then((value) {
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                controller.signoutMethod(context);
                                VxToast.show(context, msg: e.toString());
                              }
                            }
                            controller.isLoading.value=false;
                          },
                          title: signup,
                          color: _isCheck ? redColor : Vx.gray300)
                      .box
                      .width(context.screenWidth - 20)
                      .make(),
                ),
                10.heightBox,
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                    text: alreadyHaveAccount,
                    style: TextStyle(
                      color: fontGrey,
                    ),
                  ),
                  TextSpan(
                      text: ' $login',
                      style: TextStyle(color: redColor, fontFamily: bold))
                ])).onTap(() {
                  Get.back();
                })
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowLg
                .make(),
          ],
        ),
      ),
    ));
  }
}
