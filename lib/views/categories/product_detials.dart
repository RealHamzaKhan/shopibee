import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/consts/lists.dart';
import 'package:shopibee/controllers/auth_controller.dart';
import 'package:shopibee/controllers/product_controller.dart';
import 'package:shopibee/widgets_common/cutom_Button.dart';
import '../chat_screen/chat_screen.dart';

class ProductDetails extends StatelessWidget {
  var product;
  ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    final productController = Get.put(ProductController());
    productController.checkFav(docId: product.id);
    return WillPopScope(
      onWillPop: ()async{
        productController.clearValues();
        return true;

      },
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: "${product['p_name']}".text.make(),
          leading: IconButton(onPressed:(){
            Navigator.pop(context);
            productController.clearValues();
          },icon: const Icon(Icons.arrow_back)),
          actions: [
            const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.share,
                color: Colors.black,
              ),
            ),
            10.widthBox,
             Obx(()=>
                CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: (){
                    if(productController.isFav.value){
                      productController.removeFromFavourite(docId: product.id);
                    }
                    else{
                      productController.addToFavourite(docId: product.id);
                    }
                  },
                  icon: Icon(
                      Icons.favorite,
                      color: productController.isFav.value?Colors.red:Colors.black,
                    ),
                ),
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
                          viewportFraction: 1.0,
                          autoPlay: true,
                          aspectRatio: 16 / 12,
                          enlargeCenterPage: true,
                          itemCount: product['p_images'].length,
                          itemBuilder: (context, index) {
                            return Image.network(product['p_images'][index],
                                fit: BoxFit.fill);
                          }),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "${product['p_name']}"
                              .text
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          20.heightBox,
                          VxRating(
                            onRatingUpdate: (value) {},
                            selectionColor: golden,
                            size: 30,
                            maxRating: 5,
                            isSelectable: false,
                            value: double.parse(product['p_rating']),
                          ),
                          20.heightBox,
                          "${product['p_price']}"
                              .text
                              .fontFamily(bold)
                              .size(20)
                              .color(redColor)
                              .make(),
                        ],
                      )
                          .box
                          .rounded
                          .white
                          .padding(EdgeInsets.all(12))
                          .width(double.infinity)
                          .make(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller".text.make(),
                                "${product['p_seller']}".text.make(),
                              ],
                            ),
                          ),
                           CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: (){
                                Get.to(()=>const ChatScreen(),
                                    arguments: [product['vendor_id'],product['p_seller']]);
                              },
                              icon: const Icon(
                                Icons.message,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ).box.color(Vx.gray300).p8.make(),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "Colors : "
                                  .text
                                  .color(fontGrey)
                                  .make()
                                  .box
                                  .width(100)
                                  .make(),
                              Obx(()=>
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      product['p_colors'].length,
                                      (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CircleAvatar(
                                                backgroundColor: Color(int.parse(
                                                    product['p_colors'][index])),
                                              ).marginSymmetric(horizontal: 10).onTap(() {
                                                productController.changeColor(newIndex: index);
                                          }),
                                          Visibility(
                                            visible: productController.selectedColor.value==index,
                                              child: const Icon(Icons.done,color: Colors.white,))
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                          20.heightBox,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "Quaintity : "
                                  .text
                                  .color(fontGrey)
                                  .make()
                                  .box
                                  .width(100)
                                  .make(),
                              Obx(
                                () => Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                          onPressed: () {
                                            productController.decrementQuantity();
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.black,
                                          )),
                                    ),
                                    "${productController.quantity}"
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                          onPressed: () {
                                            productController.incrementQuantity(
                                                totalQuantity: int.parse(
                                                    product['p_quantity']));
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          )),
                                    ),
                                    10.widthBox,
                                    "${product['p_quantity']}"
                                        .text
                                        .color(fontGrey)
                                        .fontFamily(semibold)
                                        .size(12)
                                        .make(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                          .box
                          .white
                          .padding(EdgeInsets.all(12))
                          .width(double.infinity)
                          .make(),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            "Total Price : "
                                .text
                                .color(fontGrey)
                                .make()
                                .box
                                .width(100)
                                .make(),
                            "${productController.calculateTotalPrice(productPrice: int.parse(product['p_price']))}"
                                .text
                                .color(redColor)
                                .size(16)
                                .make()
                          ],
                        ).box.p16.red200.make(),
                      ),
                      "${product['p_desc']}"
                          .text
                          .fontFamily(regular)
                          .make()
                          .box
                          .white
                          .padding(const EdgeInsets.all(12))
                          .width(double.infinity)
                          .make(),
                      Column(
                        children: List.generate(
                          productDetailsStringsList.length,
                          (index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              productDetailsStringsList[index].text.make(),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.arrow_forward_outlined))
                            ],
                          )
                              .box
                              .white
                              .p8
                              .margin(const EdgeInsets.symmetric(vertical: 2))
                              .make(),
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
                                children: List.generate(
                                    6,
                                    (index) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              imgP1,
                                              fit: BoxFit.fill,
                                              width: 100,
                                            ),
                                            10.heightBox,
                                            "Laptop 6/512"
                                                .text
                                                .color(darkFontGrey)
                                                .semiBold
                                                .size(16)
                                                .make(),
                                            10.heightBox,
                                            "\$665".text.semiBold.make()
                                          ],
                                        )
                                            .box
                                            .roundedSM
                                            .white
                                            .padding(const EdgeInsets.symmetric(
                                                horizontal: 7, vertical: 8))
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 5))
                                            .make())),
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
                  CustomButton(
                          onPress: () async{
                            if(productController.quantity.value>0){
                              productController.addToCart(total_price: productController.totalPrice.value,
                                  title: product['p_name'],
                                  image: product['p_images'][0],
                                  seller: product['p_seller'], color: product['p_colors'][productController.selectedColor.value],
                                  quantity: productController.quantity.value,
                                  context: context,
                                  vendor_id: product['vendor_id']);
                            }
                            else{
                              VxToast.show(context, msg: "Quantity cant be 0");
                            }
                            }
                            , title: "Add to cart", color: redColor)
                      .box
                      .shadowLg
                      .size(context.screenWidth * 0.4, 50)
                      .make(),
                  CustomButton(
                          onPress: () {}, title: "Buy Now", color: Vx.yellow500)
                      .box
                      .shadowLg
                      .size(context.screenWidth * 0.4, 50)
                      .make(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
