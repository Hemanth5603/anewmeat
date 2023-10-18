import 'package:anewmeat/views/authorized/tabs/cart_page.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/authorized/tabs/profile_page.dart';
import 'package:flutter/material.dart';

class Constants{
    static List<Widget> tabs = [
      const HomePage(),
      const CartPage(),
      const ProfilePage()
  ];

  Color customRed =const Color.fromARGB(255, 206, 53, 65);

}