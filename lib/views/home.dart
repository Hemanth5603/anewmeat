import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/views/authorized/product_page.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:anewmeat/views/authorized/cart_page.dart';
import 'package:anewmeat/views/authorized/tabs/categories_page.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/authorized/tabs/profile_page.dart';
import 'package:anewmeat/views/authorized/tabs/search_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:gap/gap.dart';
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
            BarItem(filledIcon: Icons.category, outlinedIcon:Icons.category_outlined),
            BarItem(filledIcon: Icons.search, outlinedIcon:Icons.search_outlined),
            BarItem(filledIcon: Icons.person, outlinedIcon:Icons.person_outlined),
          ],
      ) ,
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children:const <Widget> [
          HomePage(),
          CategoriesPage(),
          SearchPage(),
          ProfilePage(),
        ],
      )
    );
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
        const Gap(5),
        Text(iconName,style:const TextStyle(fontFamily: 'poppins',fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),)
      ],
    ),
  );
}

