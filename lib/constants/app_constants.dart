import 'package:anewmeat/views/authorized/tabs/categories_page.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile_page.dart';
import 'package:anewmeat/views/authorized/tabs/search_page.dart';
import 'package:flutter/material.dart';

class Constants{
    static List<Widget> tabs = [
      const HomePage(),
      const CategoriesPage(),
      const SearchPage(),
      const ProfilePage(),
    
    ];

    static List<IconData> navBarIcons = [
      Icons.home_outlined,
      Icons.home_outlined,
      Icons.home_outlined,
      Icons.home_outlined,
    ];

  static Color customRed =const Color.fromARGB(255, 206, 53, 65);
  static Color customGreen =const Color.fromARGB(255,27,133,84);

}