
import 'package:flutter/material.dart';

class Constants{
   
   static List<BottomNavigationBarItem> tabs = const [
      BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_bag_outlined),
        activeIcon: Icon(Icons.shopping_bag_rounded),
        label: 'Orders'
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outlined),
        activeIcon: Icon(Icons.person),
        label: 'Account'
      )
   ];


   

  static Color customRed =const Color.fromARGB(255, 206, 53, 65);
  static Color customGreen =const Color.fromARGB(255,27,133,84);

}