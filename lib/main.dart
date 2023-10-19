import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/home.dart';
import 'package:anewmeat/views/products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(

      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Login(),
        ),
      ),
    );
  }
}


