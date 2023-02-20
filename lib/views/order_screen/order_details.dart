import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/cart_cotroller.dart';
import 'package:shopibee/views/order_screen/components/order_placed_details.dart';
import 'package:shopibee/views/order_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;
class OrderDetails extends StatelessWidget {
  var data;
  OrderDetails({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order details".text.bold.color(redColor).make(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(icon: Icons.place_rounded,color: Colors.green,status: data['order_placed'],title: "Order Placed"),
            orderStatus(icon: Icons.thumb_up_alt_rounded,color: Colors.blue,status: data['order_confirm'],title: "Confirmed"),
            orderStatus(icon: Icons.local_shipping,color: Colors.yellow,status: data['order_on_delivery'],title: "On delivery"),
            orderStatus(icon: Icons.done_all,color: Colors.purple,status: data['order_delivered'],title: "Delivered"),
            10.heightBox,
            const Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlacedDetails(color: redColor,title1: "Order Code",
                    subtitle1: data['order_code'],
                    title2: 'Shipping Method',
                    subtutle2:data['shipping_method']
                ),
                orderPlacedDetails(title1: "Order Date",
                    subtitle1: intl.DateFormat.yMMMd().format(data['order_date'].toDate()),
                    title2: 'Payment Method',
                    subtutle2:data['payment_method']
                ),
                orderPlacedDetails(title1: "Payment Status",
                    subtitle1: "Unpaid",
                    title2: 'Delivery Status',
                    subtutle2:controller.checkOrderStatus(delievered: data['order_delivered'],
                        on_delivery: data['order_on_delivery'],
                        orderPlaced: data['order_placed'],
                        confirmed: data['order_confirm']
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Shipping Address".text.fontFamily(bold).size(17).make(),
                        "Name: ${data['order_by_name']}".text.size(14).color(fontGrey).make(),
                        "Email: ${data['order_by_email']}".text.size(14).color(fontGrey).make(),
                        "Address: ${data['order_by_address']}".text.size(14).color(fontGrey).make(),
                        "City: ${data['order_by_city']}".text.size(14).color(fontGrey).make(),
                        "Province: ${data['order_by_province']}".text.size(14).color(fontGrey).make(),
                        "P#: ${data['order_by_phone']}".text.size(14).color(fontGrey).make(),
                        "Postal Code : ${data['order_by_postal_code']}".text.size(14).color(fontGrey).make(),

                      ],
                    ).box.width(context.screenWidth*0.5).make(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "Total Amount".text.fontFamily(bold).size(17).make(),
                        "${data['total_amount']}".numCurrency.text.color(redColor).fontFamily(bold).size(17).make(),
                      ],
                    ).box.width(150).make()
                  ],
                ).paddingAll(10)
              ],
            ).box.white.outerShadowSm.make(),
            10.heightBox,
            "Ordered Products".text.fontFamily(bold).size(20).make(),
            10.heightBox,
            Column(
              children:List.generate(data['orders'].length, (index){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['orders'][index]['title']}".text.size(20).color(fontGrey).make(),
                        "X ${data['orders'][index]['quantity']}".text.black.make(),
                        VxCircle(radius: 20,backgroundColor: Color(int.parse(data['orders'][index]['color'])),),

                      ],
                    ),
                    "${data['orders'][index]['total_price']}".numCurrency.text.size(20).color(redColor).make(),
                  ],
                ).box.p12.white.outerShadowSm.make();
              })
            ).box.p12.white.outerShadowSm.make()
          ],
        ),
      ),
    );
  }
}
