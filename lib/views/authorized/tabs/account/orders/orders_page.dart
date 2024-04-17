import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/billing_controller.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile_page.dart';
import 'package:anewmeat/views/home.dart';
import 'package:anewmeat/views/widgets/order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

BillingController billingController = Get.put(BillingController());

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    billingController.getOrders();
    
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 250),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon:const Icon(Icons.arrow_back_ios_rounded ,color: Colors.black,)
        ),
        
        title:const Text("Your Orders",style: TextStyle(fontFamily:'poppins',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      body:Obx(() => billingController.isLoading.value ? 
        const Center(
          child: CircularProgressIndicator(),
        )
       : billingController.orderModel!.orders.isEmpty ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Center(
              child: Text("No Orders Placed Yet !",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 35, 35, 35)),),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Get.to(const Home(), transition: Transition.leftToRight, duration: 200.milliseconds);
              },
              child: Center(
                child: Container(
                  width: w * 0.3,
                  height: h * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Constants.customRed,
                  ),
                  child: Center(child: Text("Order now ",style: TextStyle(color: Colors.white),)),
                ),
              ),
            )
         ],
       ) : Container(
          height: h,
          width: w,
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context,index){
              return OrderCard(
                w: w,
                h: h,
                index: index,
                billingController: billingController,
            );
          },
        ),
      ),
      )
    );
  }
}
