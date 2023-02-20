import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/controllers/auth_controller.dart';
import 'package:shopibee/controllers/profile_controller.dart';
import 'package:shopibee/views/auth_screen/login_screen.dart';
import 'package:shopibee/views/chat_screen/messaging_screen.dart';
import 'package:shopibee/views/order_screen/order_screen.dart';
import 'package:shopibee/views/profile/edit_profile.dart';
import 'package:shopibee/views/wishlist_screen/wishlist_screen.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';
import 'package:shopibee/widgets_common/profile_details.dart';

import '../../services/firestore_services.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FireStoreServices.getCount();
    final controller=Get.put(AuthController());
    final profileController=Get.put(ProfileController());
    return bgWidget(child: SafeArea(
      child: StreamBuilder(
          stream: FireStoreServices.getUser(uid: user!.uid),
          builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>>snapshot){
            if(!snapshot.hasData || snapshot.data==null){
             return const CircularProgressIndicator().centered();
            }
            else if(snapshot.hasError){
             return unableToFetchData.text.bold.size(17).make().box.make();
            }
            var snap=snapshot.data!.docs[0];
        return Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(onPressed: (){
                  profileController.nameController.text=snap['name'];
                  Get.to(()=>EditProfile(data: snap,));
                }, icon: const Icon(Icons.edit,color: Colors.white,))),
            Row(
              children: [
                snap['imageUrl']==''?
                Image.asset(imgP1,fit: BoxFit.cover,).box.size(60, 60).clip(Clip.antiAlias).roundedFull.make()
                :Image.network(snap['imageUrl'],fit: BoxFit.cover,).box.size(60, 60).clip(Clip.antiAlias).roundedFull.make(),
                10.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      '${snap['name']}'.text.white.fontFamily(bold).size(16).make(),
                      '${snap['email']}'.text.white.fontFamily(semibold).size(13).make()
                    ],),
                ),
                OutlinedButton(onPressed: ()async{
                  try{
                    await Get.put(AuthController()).signoutMethod(context);
                    Get.offAll(()=>const LoginScreen());
                  }
                  catch(e){
                    VxToast.show(context, msg: e.toString());
                  }
                },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Colors.white
                        )
                    ),
                    child: 'Logout'.text.white.make()
                )
              ],
            ).paddingSymmetric(horizontal: 10),
            20.heightBox,
            FutureBuilder(
                future: FireStoreServices.getCount(),
                builder: (context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        profileDetails(value: "${snap['cart_count']}", title: inYourCart),
                        profileDetails(value: "${snap['wishlist_count']}", title: inYourwishList),
                        profileDetails(value: "${snap['order_count']}", title: youOrdered),
                      ],
                    );
                  }
                  else{
                    var count=snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        profileDetails(value: "${count[0]}", title: inYourCart),
                        profileDetails(value: "${count[1]}", title: inYourwishList),
                        profileDetails(value: "${count[2]}", title: youOrdered),
                      ],
                    );
                  }
            }),
            10.heightBox,
            Column(
                children: List.generate(profileStringList.length, (index){
                  return ListTile(
                    onTap: (){
                      switch(index){
                        case 0:
                          Get.to(()=>const OrderScreen());
                          break;
                        case 1:
                          Get.to(()=>const WishListScreen());
                          break;
                        case 2:
                          Get.to(()=>const MessagesScreen());
                          break;

                      }
                    },
                    title: profileStringList[index].text.make(),
                    leading: Image.asset(profileIconsList[index],width: 25,),
                  );
                })
            ).box.rounded.white.margin(EdgeInsets.all(16)).make()
                .box.color(redColor).make()
          ],
        );
      })
    ));
  }
}
