import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:shopibee/views/categories/category_details.dart';
import 'package:shopibee/views/categories/product_detials.dart';
import 'package:shopibee/views/home_screen/components/featured_button.dart';
import 'package:shopibee/widgets_common/home_button.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchController=TextEditingController();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
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
                controller: searchController,
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: serachAnything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                  suffixIcon: IconButton(onPressed: (){
                    //get to searchscreen
                    if(searchController.text.isNotEmpty){
                      Get.to(()=>CategoryDetails(title: searchController.text,isSearch:true));
                    }

                  },icon: Icon(Icons.search)),
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
                            FeaturedButton(title: featureTitle1[index],icon: featureImages1[index]).onTap(() {
                              Get.to(()=>CategoryDetails(title: featureTitle1[index]));
                            }),
                            10.heightBox,
                            FeaturedButton(title: featureTitle2[index],icon: featureImages2[index]).onTap(() {
                              Get.to(()=>CategoryDetails(title: featureTitle2[index]));
                            })
                          ],
                        )).toList(),
                      ),
                    ),
                    10.heightBox,
                    FutureBuilder(
                      future: FireStoreServices.getFeatureProducts(),
                        //featured Products
                        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                        if(snapshot.hasError || !snapshot.hasData){
                          return Container();
                        }
                        else if(snapshot.data!.docs.isEmpty){
                          return Container();
                        }
                        else{
                          var featured=snapshot.data!.docs;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              featuredProducts.text.bold.size(20).white.make(),
                              10.heightBox,
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: List.generate(featured.length, (index) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image.network(featured[index]['p_images'][1],fit: BoxFit.cover,width: 130,height: 130,),
                                        10.heightBox,
                                        "${featured[index]['p_name']}".text.color(darkFontGrey).semiBold.size(16).makeCentered(),
                                        10.heightBox,
                                        "${featured[index]['p_price']}".numCurrency.text.semiBold.color(redColor).make().centered()
                                      ],
                                    ).box
                                        .roundedSM
                                        .white
                                        .padding(EdgeInsets.symmetric(horizontal: 7,vertical: 8))
                                        .margin(EdgeInsets.symmetric(horizontal: 5))
                                        .make().onTap(() {
                                          Get.to(()=>ProductDetails(product: featured[index]));
                                    }))
                                ),
                              )
                            ],
                          ).box.width(double.infinity).padding(EdgeInsets.all(8)).color(redColor).make();
                        }
                    }),
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
