import 'package:shopibee/consts/consts.dart';

class FireStoreServices{
  static getUser({required String uid}){
    return firestore.collection('users').where('id',isEqualTo: uid).snapshots();
  }

  //Get Products
static getProducts({required String title}){
    return firestore.collection(productCollection).where('p_category',isEqualTo: title).snapshots();
}

//get user Cart Details
static getCartDetail(){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: user!.uid).snapshots();
}
//delete cart item
static deleteItem({required document}){
     firestore.collection(cartCollection).doc(document).delete();

}

// get messages
static getChatMessage({required docId}){
    return firestore.collection(chatsCollection).doc(docId).collection(messageCollection).orderBy('created_on',descending: false).snapshots();
}
//Get all orders
static getOrders(){
    return firestore.collection(ordersCollection).where('order_by',isEqualTo:user!.uid).snapshots();
}
static getMessages(){
    return firestore.collection(chatsCollection).where('from_id',isEqualTo: user!.uid).snapshots();
}
static getWishlistProducts(){
    return firestore.collection(productCollection).where('p_wishlist',arrayContains: user!.uid).snapshots();
}
//get the profile number counts i.e in your cart wishlist etc
static getCount()async{
    var res=await Future.wait([
      firestore.collection(cartCollection).where('added_by',isEqualTo:user!.uid).get().then((value) {
       return value.docs.length;
      }),
        firestore.collection(productCollection).where('p_wishlist',arrayContains: user!.uid).get().then((value){
          return value.docs.length;
  }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo:user!.uid).get().then((value){
        return value.docs.length;
      }),
    ]);
    return res;
}
static getAllProducts(){
    return firestore.collection(productCollection).snapshots();
}
}