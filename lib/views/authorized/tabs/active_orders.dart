import 'package:anewmeat/controllers/billing_controller.dart';
import 'package:anewmeat/views/widgets/order_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:googleapis/displayvideo/v1.dart';

class ActiveOrdersPage extends StatefulWidget {
  const ActiveOrdersPage({super.key});

  @override
  State<ActiveOrdersPage> createState() => _ActiveOrdersPageState();
}

BillingController billingController = Get.put(BillingController());

class _ActiveOrdersPageState extends State<ActiveOrdersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    billingController.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title:const Text("Active Orders",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      ),
      body:Obx(() => billingController.isLoading.value ? 
        const Center(
          child: CircularProgressIndicator(),
        )
       : billingController.orderModel!.orders.isEmpty ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/sadchicken.png")
                  )
                ),
              ),SizedBox(height: 20,),
              Text("No Active Orders !",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 35, 35, 35)),),
              SizedBox(height: 5,),
              Container(
                width: w * 0.8,
                alignment: Alignment.center, 
                child: Text("🥩 Freshness awaits! No orders currently, but your next juicy meet-up is just a click away.",
                  style: TextStyle(fontSize: 14,color: const Color.fromARGB(255, 40, 40, 40)),textAlign: TextAlign.center,))
            ],
          ),
        ) : Container(
          height: h,
          width: w,
          
          
          child: ListView.builder(
            itemCount: billingController.orderModel!.orders.length,
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