import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/utils/shared_prefs.dart';
import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/authorized/cart_page.dart';
import 'package:anewmeat/views/authorized/location.dart';
import 'package:anewmeat/views/home.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'poppins',
        scaffoldBackgroundColor:const Color.fromARGB(255, 255, 255, 255),
        primaryColor: Constants.customRed,
        colorScheme: ColorScheme.light(
          primary: Constants.customRed
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home:const Scaffold(
        body: Center(
          child: Login(),
        ),
      ),
    );
  }
}


