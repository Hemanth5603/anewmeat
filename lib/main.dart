import 'dart:async';

import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/firebase_options.dart';
import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/authentication/signup.dart';
import 'package:anewmeat/views/authorized/order_track_map.dart';
import 'package:anewmeat/views/authorized/order_track_page.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:anewmeat/views/home.dart';
import 'package:anewmeat/views/utils/internet_connection.dart';
import 'package:anewmeat/views/utils/order_acknowledgement.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: Color.fromARGB(0, 233, 30, 98), // status bar color
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  isLogedIn = prefs.getInt("isLoggedIn") == null || prefs.getInt("isLoggedIn") ==  0 ? 2 : 1;
  print(prefs.getInt("isLoggedIn"));
  print(isLogedIn);
  connection = await checkConnection();
  runApp(const MainApp());
}

late SharedPreferences prefs;
int isLogedIn = 0;
bool connection = false;

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
      home:Scaffold(
        body: Center(
          child: connection == true ?
            isLogedIn == 1 ? const Home() : const SignUp() 
            : const InternetConnectionScreen(),
        ),
      ),
    );
  }
}


Future<bool> checkConnection() async{
  // bool result = false;
  // Timer.periodic(const Duration(seconds: 10), (timer) async {
  //   print("called ");

  // });
  bool result = await InternetConnectionChecker().hasConnection;
  return result;

  
}