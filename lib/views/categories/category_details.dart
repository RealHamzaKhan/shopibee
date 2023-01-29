import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/views/categories/product_detials.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';

import '../../consts/lists.dart';
class CategoryDetails extends StatelessWidget {
  String title;
  CategoryDetails({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search_rounded)),
        ],
        title: title.text.fontFamily(bold).make(),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(7, (index) => "Sub Category".text.fontFamily(semibold).makeCentered().
              box.rounded.white.size(100, 50).margin(const EdgeInsets.all(8)).make()),
            ),
          ),
          10.heightBox,
          Expanded(
            child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 6,
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
                      Image.asset(imgP5,fit: BoxFit.cover,width: 200,height: 200,),
                      const Spacer(),
                      "Laptop 6/512".text.color(darkFontGrey).semiBold.size(16).make(),
                      10.heightBox,
                      "\$665".text.semiBold.color(redColor).make()
                    ],
                  ).box
                      .roundedSM
                      .white
                      .padding(const EdgeInsets.symmetric(horizontal: 7,vertical: 8))
                      .outerShadow.margin(const EdgeInsets.symmetric(horizontal: 8,vertical: 8))
                      .make().onTap(() {
                        Get.to(()=>ProductDetails(productName: "Dummy Product",));
                  });
                }).box.white.make(),
          ),
        ],
      ),
    ));
  }
}
