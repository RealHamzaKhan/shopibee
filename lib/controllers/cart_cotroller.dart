import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/home_screen_controller.dart';

class CartController extends GetxController{
  final addressController=TextEditingController();
  final cityController=TextEditingController();
  final provinceController=TextEditingController();
  final postalCodeController=TextEditingController();
  final phoneController=TextEditingController();
  var total=0.obs;
  var paymentIndex=0.obs;
  late dynamic productSnapshot;
  var products=[];
  var isOrderPlaced=true.obs;
  void calculateTotalPrice({required data}){
    total.value=0;
    for(int i=0;i<data.length;i++){
      total.value=total.value+data[i]['total_price'] as int;
    }
  }
  void changePayment({index}){
    paymentIndex.value=index;
  }
  placeMyOrder({required paymentMethod})async{
    isOrderPlaced(false);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      "order_code":"2323234",
      "order_date":FieldValue.serverTimestamp(),
      "order_by":user!.uid,
      "order_by_name":Get.put(HomeScreenController()).username,
      "order_by_email":user!.email,
      "order_by_address":addressController.text,
      "order_by_province":provinceController.text,
      "order_by_city":cityController.text,
      "order_by_postal_code":postalCodeController.text,
      "order_by_phone":phoneController.text,
      "shipping_method":"Home delivery",
      "payment_method":paymentMethod,
      "order_placed":true,
      "order_confirm":false,
      "order_delivered":false,
      "order_on_delivery":false,
      "total_amount":total.value,
      "orders":FieldValue.arrayUnion(products),



    });
    isOrderPlaced(true);
}
getProductDetails()async{
    for(int i=0;i<productSnapshot.length;i++){
      products.add({
        "title":productSnapshot[i]['title'],
        "color":productSnapshot[i]['color'],
        'vendor_id':productSnapshot[i]['vendor_id'],
        'total_price':productSnapshot[i]['total_price'],
        'image':productSnapshot[i]['image'],
        'quantity':productSnapshot[i]['quantity'],
      });
    }
}
  clearCart()async{
    for(int i=0;i<productSnapshot.length;i++){
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
  checkOrderStatus({on_delivery,delievered,confirmed,orderPlaced}){
    if(delievered){
      return "Delivered";
    }
    else if(on_delivery){
      return "On Delivery";
    }
    else if(confirmed){
      return "Confirmed";
    }
    else if(orderPlaced){
      return "Order Placed";
    }
  }
}