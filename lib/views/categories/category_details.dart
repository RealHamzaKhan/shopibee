import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/product_controller.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:shopibee/views/categories/product_detials.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';

import '../../consts/lists.dart';
class CategoryDetails extends StatelessWidget {
  String title;
  CategoryDetails({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ProductController());
    return bgWidget(child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded)),
        ],
        title: title.text.fontFamily(bold).make(),
      ),
      body:StreamBuilder(
          stream: FireStoreServices.getProducts(title: title),
          builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData || snapshot.data==null){
              return const CircularProgressIndicator().centered();
            }
            else if(snapshot.data!.docs.isEmpty){
              return "No Products available".text.color(darkFontGrey).bold.size(20).makeCentered();
            }
            else{
              var data=snapshot.data!.docs;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(controller.subcat.length, (index) => "${controller.subcat[index]}".text.fontFamily(semibold).makeCentered().
                      box.rounded.white.size(100, 50).p4.margin(const EdgeInsets.all(8)).makeCentered()),
                    ),
                  ),
                  10.heightBox,
                  Expanded(
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: data.length,
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 300,
                        ),
                        itemBuilder: (context,index){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(data[index]['p_images']![0],fit: BoxFit.cover,width: 200,height: 200,),
                              const Spacer(),
                              "${data[index]['p_name']}".text.color(darkFontGrey).semiBold.size(16).make(),
                              10.heightBox,
                              "${data[index]['p_price']}".text.semiBold.color(redColor).make()
                            ],
                          ).box
                              .roundedSM
                              .white
                              .padding(const EdgeInsets.symmetric(horizontal: 7,vertical: 8))
                              .outerShadow.margin(const EdgeInsets.symmetric(horizontal: 8,vertical: 8))
                              .make().onTap(() {
                            Get.to(()=>ProductDetails(product: data[index],));
                          });
                        }).box.white.make(),
                  ),
                ],
              );
            }

          })
    ));
  }
}
