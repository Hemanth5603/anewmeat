import 'package:anewmeat/views/authorized/product_page.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:anewmeat/views/authorized/cart_page.dart';
import 'package:anewmeat/views/authorized/tabs/categories_page.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/authorized/tabs/profile_page.dart';
import 'package:anewmeat/views/authorized/tabs/search_page.dart';
import 'package:anewmeat/views/home.dart';
import 'package:flutter/material.dart';

class Constants{
    static List<Widget> tabs = [
      const HomePage(),
      CategoriesPage(),
      SearchPage(),
      const ProfilePage(),
    
    ];

    static List<IconData> navBarIcons = [
      Icons.home_outlined,
      Icons.home_outlined,
      Icons.home_outlined,
      Icons.home_outlined,
    ];

  static Color customRed =const Color.fromARGB(255, 206, 53, 65);

}