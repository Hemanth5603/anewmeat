import 'dart:io';

import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/category_controller.dart';
import 'package:anewmeat/controllers/products_controller.dart';
import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile_page.dart';
import 'package:anewmeat/views/authorized/search_page.dart';
import 'package:anewmeat/views/authorized/tabs/active_orders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  
  late bool isLoading = false;
  CategoryController categoriesController = Get.put(CategoryController());
  CartController cartController = Get.put(CartController());
  ProductController productController = Get.put(ProductController());


  var selectedIndex = 0;
  late PageController pageController;
  
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    isLoading = true;
     WidgetsBinding.instance.addPostFrameCallback((_)async {
      await initializeHome();
     });
    pageController.addListener(() {
      int currentPage = pageController.page!.round();
      if (currentPage != selectedIndex) {
        setState(() {
          selectedIndex = currentPage;
        });
      }
    });
  }

  Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue 
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 150,
            width: 100,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Really wanted to leave ??",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                const SizedBox(height: 25,),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.asset("assets/icons/sadchicken.png"),
                ),
              ],
            ),
          ),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
               //return false when click on "NO"
              child:const Text('No'),
            ),

            ElevatedButton(
              onPressed: () => exit(0),
              //return true when click on "Yes"
              child:const Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }
  

  
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      onPopInvoked: (_){
        showExitPopup();
        return;
      },
      child: Scaffold(
         bottomNavigationBar:BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Constants.customRed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          elevation: 10,
          currentIndex: selectedIndex,
          onTap: (value){
            setState(() {
              if(value == 0){ initializeHome();}
              selectedIndex = value;
            });
            pageController.animateToPage(selectedIndex,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutQuad);
          },
          items:Constants.tabs
         ),
        body: Skeletonizer(
          enabled: isLoading,
          child:  PageView(
              controller: pageController,
              children:const <Widget> [
                HomePage(),
                ActiveOrdersPage(),
                ProfilePage(),
              ],
            ),
          ),
      ),
    );
  }
  
Future initializeHome() async{
  setState(() {
    isLoading = true;
  });
  await userController.getUser();
  await cartController.getCartItems();
  await productController.fetchAllProducts();
  await categoriesController.fetchCategories();
  await billingController.getOrders();
  //cartController.getCartLength();
  setState(() {
    isLoading = false;
  });
}

}



Widget BottomNavBar(w,h){
  return Container(
    width: w,
    height: h * 0.08,
    padding:const EdgeInsets.only(top: 10),
    color: Constants.customRed,
    child: ListView(
      scrollDirection: Axis.horizontal,
      physics:const NeverScrollableScrollPhysics(),
     children: [
      GestureDetector(child: BottomNavbarItem(Icons.home_outlined,"Home")),
      BottomNavbarItem(Icons.home_outlined,"Home"),
      BottomNavbarItem(Icons.home_outlined,"Home"),
      BottomNavbarItem(Icons.home_outlined,"Home"),
     ],
    ),
  );
}



Widget BottomNavbarItem(icon,iconName){
  return Container(
    width: 95,
    height: 150,
    child: Column(
      children: [
        Icon(icon,size: 30,color: Colors.white,),
        SizedBox(height: 5,),
        Text(iconName,style:const TextStyle(fontFamily: 'poppins',fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),)
      ],
    ),
  );
}


