import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/cart_cotroller.dart';
import 'package:shopibee/views/cart/payment_method.dart';
import 'package:shopibee/widgets_common/custom_text_field.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';
class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController=Get.put(CartController());
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: "Shopping Info".text.make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: CustomButton(onPress: (){
          if(cartController.addressController.text.isEmpty || cartController.addressController.text.length<10){
            VxToast.show(context, msg: "Provide a proper address",bgColor: redColor);
          }
          else if(cartController.cityController.text.isEmpty || cartController.provinceController.text.isEmpty
          || cartController.postalCodeController.text.isEmpty || cartController.phoneController.text.isEmpty){
            VxToast.show(context, msg: "Kindly fill all the fields",bgColor: redColor);
          }
          else{
            //Continue
            Get.to(()=>const PaymentMethod());
          }
        }, title: "Continue", color: redColor),
      ),
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            customTextField(title: "Address", hintText: "house#123,Street 3,Sector 2,Islamabad", controller: cartController.addressController),
            customTextField(title: "City", hintText: "Islamabad", controller: cartController.cityController),
            customTextField(title: "Province", hintText: "Punjab", controller: cartController.provinceController),
            customTextField(title: "Postal Code", hintText: "20032", controller: cartController.postalCodeController),
            customTextField(title: "Phone", hintText: "03123456789", controller: cartController.phoneController),
          ],
        ).paddingAll(20),
      ),
    );
  }
}
