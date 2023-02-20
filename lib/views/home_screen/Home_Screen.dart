import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:shopibee/views/categories/product_detials.dart';
import 'package:shopibee/views/home_screen/components/featured_button.dart';
import 'package:shopibee/widgets_common/home_button.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: lightGrey,
                boxShadow: [
                  BoxShadow(
                    color: Vx.gray200,
                    offset: Offset(3, 5),
                  )
                ],
              ),
              height: context.screenHeight*0.05,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: serachAnything,
                  hintStyle: TextStyle(color: textfieldGrey),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16/9,
                        height: context.screenHeight*0.2,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                       // enlargeCenterPage: true,

                        itemCount: sliderImages.length, itemBuilder: (context,index){
                      return Image.asset(sliderImages[index],fit: BoxFit.fill,).box.rounded.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) =>
                          Homebutton(
                              icon: index==0?icTodaysDeal:icFlashDeal,
                              title: index==0?todayDeal:flashSale,
                              height: context.screenHeight*0.13,
                              width: context.screenWidth*0.4)),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        height: context.screenHeight*0.2,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        enlargeCenterPage: true,

                        itemCount: secondSliderimages.length, itemBuilder: (context,index){
                      return Image.asset(secondSliderimages[index],fit: BoxFit.fill,).box.rounded.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) =>
                          Homebutton(
                              icon: index==0?icTopCategories:index==1?icBrands:icTopSeller,
                              title: index==0?topCategories:index==1?brands:topSellers,
                              height: context.screenHeight*0.12,
                              width: context.screenWidth*0.26)),
                    ),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredcategories.text.black.bold.size(18).make()),
                    10.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(3, (index) => Column(
                          children: [
                            FeaturedButton(title: featureTitle1[index],icon: featureImages1[index]),
                            10.heightBox,
                            FeaturedButton(title: featureTitle2[index],icon: featureImages2[index])
                          ],
                        )).toList(),
                      ),
                    ),
                    10.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProducts.text.bold.size(20).white.make(),
                        10.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(6, (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(imgP1,fit: BoxFit.fill,width: 100,),
                                10.heightBox,
                                "Laptop 6/512".text.color(darkFontGrey).semiBold.size(16).make(),
                                10.heightBox,
                                "\$665".text.semiBold.make()
                              ],
                            ).box
                                .roundedSM
                                .white
                                .padding(EdgeInsets.symmetric(horizontal: 7,vertical: 8))
                                .margin(EdgeInsets.symmetric(horizontal: 5))
                                .make())
                          ),
                        )
                      ],
                    ).box.width(double.infinity).padding(EdgeInsets.all(8)).color(redColor).make(),
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        height: context.screenHeight*0.2,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        enlargeCenterPage: true,

                        itemCount: secondSliderimages.length, itemBuilder: (context,index){
                      return Image.asset(secondSliderimages[index],fit: BoxFit.fill,).box.rounded.margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    }),
                    10.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: allProducts.text.bold.size(20).make()),
                    10.heightBox,
                    StreamBuilder(
                        stream: FireStoreServices.getAllProducts(),
                        builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                          if(!snapshot.hasData || snapshot.hasError){
                            return Container();
                          }
                          else{
                            var allprod=snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allprod.length,
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
                                      Image.network(allprod[index]['p_images'][1],fit: BoxFit.cover,width: 200,height: 200,),
                                      const Spacer(),
                                      "${allprod[index]['p_name']}".text.color(darkFontGrey).semiBold.size(16).make(),
                                      10.heightBox,
                                      "${allprod[index]['p_price']}".numCurrency.text.semiBold.color(redColor).make()
                                    ],
                                  ).box
                                      .roundedSM
                                      .white
                                      .padding(const EdgeInsets.symmetric(horizontal: 7,vertical: 8))
                                      .shadowSm.margin(const EdgeInsets.symmetric(horizontal: 5))
                                      .make().onTap(() {
                                        Get.to(()=>ProductDetails(product: snapshot.data!.docs[index]));
                                  });
                                });
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
