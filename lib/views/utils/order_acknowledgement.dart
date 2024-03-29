import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/displayvideo/v1.dart';
import 'package:lottie/lottie.dart';

class OrderAcknowledgement extends StatefulWidget {
  const OrderAcknowledgement({super.key});

  @override
  State<OrderAcknowledgement> createState() => _OrderAcknowledgementState();
}

class _OrderAcknowledgementState extends State<OrderAcknowledgement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
             color: Constants.customRed,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Track Order",style: TextStyle(fontSize: 18,color: Colors.white),),
                SizedBox(width: 6,),
                Icon(Icons.arrow_right_alt_rounded,size: 30,color: Colors.white,)
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: const Color.fromARGB(255, 114, 222, 117)
                ),
                child:const Icon(Icons.check,size: 80,color: Colors.white,),
              ),
              const SizedBox(height: 15,),
              const Text("Order Recieved !", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: const Color.fromARGB(255, 126, 230, 129)),)
            ],
          )
        ),
      ),
    );
  }
}