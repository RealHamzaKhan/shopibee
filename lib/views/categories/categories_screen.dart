import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/views/categories/category_details.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(child: Scaffold(
      appBar: AppBar(
        title: 'Categories'.text.make(),
      ),
      body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        mainAxisExtent: 220,
        crossAxisSpacing: 8
      ),
        itemCount: 9,
        itemBuilder: (context,index){
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(categoriesImages[index],fit: BoxFit.cover,width: 200,height: 140,),
            const Spacer(),
            categoriestitles[index].text.color(darkFontGrey).align(TextAlign.center).semiBold.size(16).makeCentered(),
          ],
        ).box
            .rounded
            .white
            .padding(const EdgeInsets.symmetric(horizontal: 7,vertical: 8))
            .shadowSm.margin(const EdgeInsets.symmetric(horizontal: 5))
            .make().onTap(() {
              Get.to(()=>CategoryDetails(title: categoriestitles[index]));
        });
    }),
    ));
  }
}
