import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/models/categoryModel.dart';

class ProductController extends GetxController{
  var subcat=[];
  var quantity=0.obs;
  var totalPrice=0.obs;
  var selectedColor=0.obs;
  var isFav=false.obs;
  getSubCategories(title)async{
    subcat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var decodedData=categoriesModelFromJson(data);
    var s=decodedData.categories.where((element) => element.name==title).toList();
    for(var e in s[0].subcategories){
      subcat.add(e);
    }
  }
  void incrementQuantity({required int totalQuantity}){
    if(quantity.value<totalQuantity){
      quantity.value++;
    }
  }
  void decrementQuantity(){
    if(quantity.value>0){
      quantity.value--;
    }
  }
  int calculateTotalPrice({required int productPrice}){
    totalPrice.value=quantity.value*productPrice;
    return totalPrice.value;
  }
  void changeColor({required int newIndex}){
    selectedColor.value=newIndex;
  }
  void addToCart({required total_price,required title,required image,required seller,
  required color,required quantity,required vendor_id,required context
  })async{
    try{
      await firestore.collection(cartCollection).doc().set({
        "title":title,
        "total_price":total_price,
        "image":image,
        "seller":seller,
        "color":color,
        'vendor_id':vendor_id,
        "quantity":quantity,
        "added_by":user!.uid
      });
      VxToast.show(context, msg: "Added to cart");
    }
    catch(e){
      VxToast.show(context, msg: "Couldn't add to cart try again");
    }


  }
  void clearValues(){
    totalPrice.value=0;
    quantity.value=0;
    selectedColor.value=0;
  }
  addToFavourite({required docId})async{
    isFav(true);
    await firestore.collection(productCollection).doc(docId).update({
      'p_wishlist':FieldValue.arrayUnion([user!.uid])
    });
  }
  removeFromFavourite({required docId})async{
    isFav(false);
    await firestore.collection(productCollection).doc(docId).update({
      'p_wishlist':FieldValue.arrayRemove([user!.uid])
    });
  }
  checkFav({required docId})async{
    await firestore.collection(productCollection).doc(docId).get().then((value){
      if(value['p_wishlist'].contains(user!.uid)){
        isFav(true);
      }
      else{
        isFav(false);
      }
    });
  }

}