import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/category_controller.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/authorized/tabs/profile_page.dart';
import 'package:anewmeat/views/authorized/tabs/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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
  

  
  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
       bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Constants.customRed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        elevation: 10,
        currentIndex: selectedIndex,
        onTap: (value){
          setState(() {
            selectedIndex = value;
          });
          pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutQuad);
        },
        items:const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Search'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: 'Account'
          )
        ],
       ),
       
       /*WaterDropNavBar(
        backgroundColor: Constants.customRed,
        onItemSelected: (index){
          setState(() {
            selectedIndex = index;
          });          
          pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutQuad);
        }, 
        selectedIndex: selectedIndex,
        bottomPadding: 10,
        waterDropColor :Colors.white,
          barItems : <BarItem>[
            BarItem(filledIcon: Icons.home, outlinedIcon:Icons.home_outlined,),
            BarItem(filledIcon: Icons.search, outlinedIcon:Icons.search_outlined),
            BarItem(filledIcon: Icons.person, outlinedIcon:Icons.person_outlined),
          ],
      ) ,*/
      body: Skeletonizer(
        enabled: isLoading,
        child:  PageView(
            controller: pageController,
            children:const <Widget> [
              HomePage(),
              SearchPage(),
              ProfilePage(),
            ],
          ),
        ),
    );
  }
  
Future initializeHome() async{
  setState(() {
    isLoading = true;
  });
  await categoriesController.fetchCategories();
  await cartController.getCartItems();
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


