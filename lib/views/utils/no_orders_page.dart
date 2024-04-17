import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoOrdersPage extends StatelessWidget {
  const NoOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),

      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.06,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Constants.customRed,
        ),
        child: GestureDetector(
          onTap: () => Get.offAll(const Home()),
          child: const Center(child: Text("Explore Products",style: TextStyle(fontSize: 15,color: Colors.white),),)),
      ),
      body:const  SafeArea(
        child: Center(
          child: Text("No Orders Yet !",style: TextStyle(fontSize: 18,),),
        ),
      ),
    );
  }
}