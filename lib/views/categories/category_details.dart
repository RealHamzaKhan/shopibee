import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/product_controller.dart';
import 'package:shopibee/services/firestore_services.dart';
import 'package:shopibee/views/categories/product_detials.dart';
import 'package:shopibee/widgets_common/bg_widget.dart';

class CategoryDetails extends StatefulWidget {
  bool isSearch;
  String title;
  CategoryDetails({Key? key,required this.title, this.isSearch=false}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  dynamic productStream;
  final controller=Get.put(ProductController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategory(title: widget.title);
  }
  void switchCategory({title}){
    if(controller.subcat.contains(title)){
      productStream=FireStoreServices.getSubCategoryProducts(title: title);
    }
    else{
      productStream=FireStoreServices.getProducts(title: title);
    }
  }
  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ProductController());
    return bgWidget(child: Scaffold(
      appBar: AppBar(
        title: widget.title.text.fontFamily(bold).make(),
      ),
      body:Column(
        children: [
          widget.isSearch?Container():SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(controller.subcat.length, (index) => "${controller.subcat[index]}".text.fontFamily(semibold).makeCentered().
              box.rounded.white.size(100, 50).p4.margin(const EdgeInsets.all(8)).makeCentered().onTap(() {
                switchCategory(title:controller.subcat[index] );
                setState(() {

                });
              })),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: widget.isSearch?FireStoreServices.searchProduct(product: widget.title):productStream,
                builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
                  if(!snapshot.hasData || snapshot.data==null){
                    return const CircularProgressIndicator().centered();
                  }
                  else if(snapshot.data!.docs.isEmpty){
                    return "No Products available".text.color(darkFontGrey).bold.size(20).makeCentered();
                  }
                  else{
                    var data=snapshot.data!.docs;
                    var filtered=data.where((element) => element['p_name'].toString().toLowerCase().contains(widget.title.toLowerCase())).toList();
                    return widget.isSearch?
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.heightBox,
                        Expanded(
                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: filtered.length,
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
                                    Image.network(filtered[index]['p_images']![0],fit: BoxFit.cover,width: 200,height: 200,),
                                    const Spacer(),
                                    "${filtered[index]['p_name']}".text.color(darkFontGrey).semiBold.size(16).make(),
                                    10.heightBox,
                                    "${filtered[index]['p_price']}".text.semiBold.color(redColor).make()
                                  ],
                                ).box
                                    .roundedSM
                                    .white
                                    .padding(const EdgeInsets.symmetric(horizontal: 7,vertical: 8))
                                    .outerShadow.margin(const EdgeInsets.symmetric(horizontal: 8,vertical: 8))
                                    .make().onTap(() {
                                  Get.to(()=>ProductDetails(product: filtered[index],));
                                });
                              }).box.white.make(),
                        ),
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

                }),
          ),
        ],
      )
    ));
  }
}
