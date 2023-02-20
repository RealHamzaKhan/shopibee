import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/cart_cotroller.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:shopibee/views/cart/shopping_screen.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';
class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CartController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: "Your Cart".text.bold.make(),
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getCartDetail(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
        if(!snapshot.hasData){
          return const CircularProgressIndicator().centered();
        }
        else if(snapshot.data!.docs.isEmpty){
          return "Cart is Empty".text.bold.size(20).color(fontGrey).makeCentered();
        }
        else{
          var snap=snapshot.data!.docs;
          controller.calculateTotalPrice(data: snap);
          controller.productSnapshot=snap;
         return Column(
            children: [
              Expanded(
                  child:ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          title: '${snap[index]['title']} (x${snap[index]['quantity']})'.text.make(),
                          leading: Image.network(snap[index]['image']),
                          subtitle: '${snap[index]['total_price']}'.text.color(redColor).fontFamily(semibold).size(16).make(),
                          trailing: IconButton(onPressed: ()async{
                            await FireStoreServices.deleteItem(document: snap[index].id);
                            // ignore: use_build_context_synchronously
                            VxToast.show(context, msg: "Item Deleted");
                          },
                              icon: const Icon(Icons.delete,color: redColor,)),
                        ).box.margin(const EdgeInsets.symmetric(vertical: 5)).make();
                  })
              ),
              10.heightBox,
              Obx(()=>
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total Price".text.fontFamily(semibold).color(redColor).size(15).make(),
                    "${controller.total}".text.fontFamily(semibold).color(redColor).size(15).make(),
                  ],
                ),
              ),
              10.heightBox,
              CustomButton(onPress: (){
                Get.to(()=>const ShoppingScreen());
              }, title: "Proceed to shipping", color: redColor).box.width(double.infinity).make()
            ],
          ).paddingAll(12);
        }
      })
    );
  }
}
