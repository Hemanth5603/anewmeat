import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/authorized/tabs/cart_page.dart';
import 'package:anewmeat/views/home.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:const Scaffold(
        body: Center(
          child: CartPage(),
        ),
      ),
    );
  }
}


