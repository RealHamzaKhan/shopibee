import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/controllers/cart_cotroller.dart';
import 'package:shopibee/views/home_screen/home.dart';

import '../../widgets_common/cutom_Button.dart';
class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartController=Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Choose payment method".text.make(),
        foregroundColor: Colors.black,
      ),
      bottomNavigationBar: Obx(()=>
         SizedBox(
          height: 60,
          child: !cartController.isOrderPlaced.value?const CircularProgressIndicator(color: redColor,).centered()
              :CustomButton(onPress: ()async{
            try{
              await cartController.placeMyOrder(paymentMethod: paymentMethodsStringList[cartController.paymentIndex.value]);
              await cartController.clearCart();
              VxToast.show(context, msg: 'Order Placed');
              Get.offAll(const Home());


            }
            catch(e){
              print(e.toString());
              VxToast.show(context, msg: "An unknown error occurred while placing order",bgColor: redColor);
            }

          }, title: "Place order", color: redColor),
        ),
      ),
      body: Obx(()=>
         Column(
          children: List.generate(paymentMethodsImagesList.length, (index){
            return GestureDetector(
              onTap: (){
                cartController.changePayment(index: index);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: context.screenHeight*0.15,
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: cartController.paymentIndex.value==index?BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: redColor,width: 4),
                ):BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    cartController.paymentIndex.value==index?
                    Image.asset(paymentMethodsImagesList[index],fit: BoxFit.fill,width: double.infinity,
                    colorBlendMode: BlendMode.darken,color: Colors.black.withOpacity(0.5),)
                        :Image.asset(paymentMethodsImagesList[index],fit: BoxFit.fill,width: double.infinity,),
                    cartController.paymentIndex.value==index? Transform.scale(
                      scale: 1.4,
                      child: Checkbox(value: true, onChanged: (value){}
                      ,activeColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                      ),
                    ):Container(),
                    Positioned(
                        bottom: 5,
                        right: 5,
                        child: "${paymentMethodsStringList[index]}".text.white.bold.size(17).make())
                  ],
                ),
              ),
            );
          }),
        ).paddingAll(20),
      ),
    );
  }
}
