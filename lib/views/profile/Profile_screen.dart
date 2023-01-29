import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/controllers/auth_controller.dart';
import 'package:shopibee/views/auth_screen/login_screen.dart';
import 'package:shopibee/views/profile/edit_profile.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';
import 'package:shopibee/widgets_common/profile_details.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(child: SafeArea(
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: IconButton(onPressed: (){
                Get.to(()=>const EditProfile());
              }, icon: const Icon(Icons.edit,color: Colors.white,))),
          Row(
            children: [
              Image.asset(imgP1,fit: BoxFit.cover,).box.size(60, 60).clip(Clip.antiAlias).roundedFull.make(),
              10.widthBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  'Dummy Name'.text.white.fontFamily(bold).size(16).make(),
                    'Costumer2@gmail.com'.text.white.fontFamily(semibold).size(13).make()
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              profileDetails(value: "00", title: inYourCart),
              profileDetails(value: "00", title: inYourwishList),
              profileDetails(value: "00", title: youOrdered),
            ],
          ),
          10.heightBox,
          Column(
            children: List.generate(profileStringList.length, (index){
              return ListTile(
                title: profileStringList[index].text.make(),
                leading: Image.asset(profileIconsList[index],width: 25,),
              );
            })
          ).box.rounded.white.margin(EdgeInsets.all(16)).make()
          .box.color(redColor).make()
        ],
      ),
    ));
  }
}
