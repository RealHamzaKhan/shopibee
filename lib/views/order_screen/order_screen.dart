import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:shopibee/views/order_screen/order_details.dart';
class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getOrders(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return const CircularProgressIndicator(color: redColor,).centered();
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No orders found".text.bold.size(20).color(fontGrey).makeCentered();
            }
            else{
              var snap=snapshot.data!.docs;
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      onTap: (){
                        Get.to(()=>OrderDetails(data: snap[index]));
                      },
                      leading: "${index+1}".text.make(),
                      title: snap[index]['order_code'].toString().text.bold.color(Vx.black).make(),
                      subtitle: snap[index]['total_amount'].toString().numCurrency.text.color(redColor).make(),
                      trailing: IconButton(icon: Icon(Icons.arrow_forward_ios),onPressed: (){},),
                    ).box.white.outerShadowSm.margin(const EdgeInsets.only(bottom: 5)).make();
              });
            }
      }),
    );
  }
}
