import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/views/authorized/product_page.dart';
import 'package:anewmeat/views/authorized/tabs/cart_page.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/authorized/tabs/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  

  final _controller = NotchBottomBarController(index: 0);
  var selectedIndex = 0;
  late PageController pageController;
  
  @override
  void initState() {
    // TODO: implement initState
    
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar:WaterDropNavBar(
        backgroundColor: Constants.customRed,
        onItemSelected: (index){
          setState(() {
            selectedIndex = index;
          });          
          pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
        }, 
        selectedIndex: selectedIndex,
        bottomPadding: 10,
        waterDropColor :Colors.white,
          barItems : <BarItem>[
            BarItem(filledIcon: Icons.home, outlinedIcon:Icons.home_outlined,),
            BarItem(filledIcon: Icons.shopping_cart, outlinedIcon:Icons.shopping_cart_outlined),
            BarItem(filledIcon: Icons.person_2, outlinedIcon:Icons.person_2_outlined),
          ],
      ) ,
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children:const <Widget> [
          HomePage(),
          CartPage(),
          ProductPage(),
        ],
      )
    );
  }
}