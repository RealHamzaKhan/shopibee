import 'package:flutter/material.dart';
import 'package:shopibee/consts/consts.dart';
import 'package:shopibee/controllers/home_screen_controller.dart';
import 'package:shopibee/views/cart/cart_screen.dart';
import 'package:shopibee/views/profile/Profile_screen.dart';

import '../categories/categories_screen.dart';
import 'Home_Screen.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navController=Get.put(HomeScreenController());
    var navItems=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 25,),label: home,),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 25,),label: categories,),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 25,),label: cart,),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 25,),label: account,),
    ];
    var navViews=const[
      HomeScreen(),
      CategoriesScreen(),
      CartScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(child: navViews[navController.navItemIndex.value])),
        ],
      ),
      bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: navController.navItemIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: TextStyle(fontFamily: bold),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: navItems,
            onTap: (newValue){
              navController.navItemIndex.value=newValue;
    },
        ),
      ),
    );
  }
}
