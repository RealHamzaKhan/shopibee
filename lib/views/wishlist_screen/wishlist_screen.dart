import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/services/firestore_services.dart';
class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.make(),
      ),
      body: StreamBuilder(
          stream: FireStoreServices.getWishlistProducts(),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return const CircularProgressIndicator(color: redColor,).centered();
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No item found".text.bold.size(20).color(fontGrey).makeCentered();
            }
            else{
              var snap=snapshot.data!.docs;
              return ListView(
                children: List.generate(snap.length, (index){
                  return ListTile(
                    leading: Image.network(snap[index]['p_images'][1],fit: BoxFit.cover,).box.size(60, 60).make(),
                    subtitle: "${snap[index]['p_price']}".numCurrency.text.color(redColor).make(),
                    title: "${snap[index]['p_name']}".text.make(),
                    trailing: IconButton(onPressed: ()async{
                      firestore.collection(productCollection).doc(snap[index].id).update({
                        'p_wishlist':FieldValue.arrayRemove([user!.uid])
                      });
                    }, icon: const Icon(Icons.favorite,color: redColor,)),
                  );
                }),
              );
            }
          }),
    );
  }
}
