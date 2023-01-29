import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';

class ProductDetails extends StatelessWidget {
  String productName;
  ProductDetails({Key? key,required this.productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        actions: [
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.share,
              color: Colors.black,
            ),
          ),
          10.widthBox,
          const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              Icons.favorite_outline,
              color: Colors.black,
            ),
          ),
        ],
      ),
      backgroundColor: lightGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        aspectRatio: 16/12,
                        enlargeCenterPage: true,
                        itemCount: 3, itemBuilder: (context,index){
                      return Image.asset(imgSlider1,fit: BoxFit.fill);
                    }),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productName.text.fontFamily(bold).size(18).make(),
                        20.heightBox,
                        VxRating(onRatingUpdate: (value){},selectionColor: golden,size: 30,),
                        20.heightBox,
                        "\$5000".text.fontFamily(bold).size(20).color(redColor).make(),
                      ],
                    ).box.rounded.white.padding(EdgeInsets.all(12)).width(double.infinity).make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.make(),
                              "In House Product".text.make(),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message,color: Colors.black,),
                        )
                      ],
                    ).box.color(Vx.gray300).p8.make(),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Colors : ".text.color(fontGrey).make().box.width(100).make(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(3, (index) => CircleAvatar(
                                backgroundColor: Vx.randomColor,
                              ).marginSymmetric(horizontal: 10)),
                            )
                          ],
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Quaintity : ".text.color(fontGrey).make().box.width(100).make(),
                            Row(
                              children: [
                                 CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(onPressed:(){},icon: const Icon(Icons.remove,color: Colors.black,)),
                                ),
                                "0".text.fontFamily(semibold).size(16).make(),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: IconButton(onPressed:(){},icon: const Icon(Icons.add,color: Colors.black,)),
                                ),
                                10.widthBox,
                                "10 available".text.color(fontGrey).fontFamily(semibold).size(12).make(),
                              ],
                            )
                          ],
                        ),

                      ],
                    ).box.white.padding(EdgeInsets.all(12)).width(double.infinity).make(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        "Total Price : ".text.color(fontGrey).make().box.width(100).make(),
                        "\$88".text.color(redColor).size(16).make()
                      ],
                    ).box.p16.red200.make(),
                    "Description of a product will be written here"
                    .text.fontFamily(regular).make().box.white.padding(const EdgeInsets.all(12)).width(double.infinity).make(),
                    Column(
                      children: List.generate(productDetailsStringsList.length, (index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          productDetailsStringsList[index].text.make(),
                          IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_outlined))
                        ],
                      ).box.white.p8.margin(const EdgeInsets.symmetric(vertical: 2)).make(),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        productYouLike.text.fontFamily(semibold).make(),
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
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
                                  .padding(const EdgeInsets.symmetric(horizontal: 7,vertical: 8))
                                  .margin(const EdgeInsets.symmetric(horizontal: 5))
                                  .make())
                          ),
                        )
                      ],
                    ).box.white.p12.make()

                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(onPress: (){}, title: "Add to cart", color: redColor).box.shadowLg.size(context.screenWidth*0.4, 50).make(),
                CustomButton(onPress: (){}, title: "Buy Now", color: Vx.yellow500).box.shadowLg.size(context.screenWidth*0.4, 50).make(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
