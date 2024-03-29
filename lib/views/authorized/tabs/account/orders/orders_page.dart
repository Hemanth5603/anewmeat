import 'package:anewmeat/controllers/billing_controller.dart';
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
       : Container(
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


class OrderCard extends StatefulWidget {
  OrderCard({
    super.key,
    required this.w,
    required this.h,
    required this.index,
    required this.billingController
  });
  double w;
  double h;
  int index;
  BillingController billingController;
  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final data =  billingController.orderModel?.orders[0];
   late double cHeight = widget.h * data!.items.length * 0.125;
  bool isExtended = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:const Duration(milliseconds: 200),
      width: widget.w,
      height: cHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            color: Color.fromARGB(111, 189, 189, 189),
            blurRadius: 10
          )
        ],
        borderRadius: BorderRadius.circular(5),
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order ID: ${data?.orderId}",style: const TextStyle(fontFamily: 'poppins',color: Colors.grey,fontSize: 12),),
          const SizedBox(height: 2,),
          Text("${data?.date} | ${data?.time}",style: const TextStyle(fontFamily: 'poppins',color: Color.fromARGB(255, 110, 110, 110),fontSize: 12),),
          const SizedBox(height: 10,),
          const Text("Ordered Items",style: TextStyle(fontFamily: 'poppins',color: Color.fromARGB(255, 0, 0, 0),fontSize: 14,fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          SizedBox(
            width: widget.w,
            height: widget.h * data!.items.length * 0.04,
            child: ListView.builder(
              itemCount: data?.items.length,
              itemBuilder: (context,index){
                return itemTile(
                  widget.w,
                  widget.h,
                  data?.items[index].productName,
                  data?.items[index].value,
                  data?.items[index].finalPrice
                );
              },
            ),
          ),
          Container(
            width: widget.w,
            height: 1,
            color: const Color.fromARGB(255, 213, 213, 213),
          ),
          const SizedBox(height: 0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Bill Details",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
              IconButton(
                onPressed:(){
                  setState(() {
                    if(isExtended){
                      cHeight = widget.h * data!.items.length * 0.125;
                      isExtended = false;
                    }
                    else{
                      cHeight = widget.h * data!.items.length * 0.2;
                      isExtended = true;
                    }
                  });
                },
                icon: isExtended
                ? const Icon(Icons.arrow_drop_up_rounded,size: 30,)
                : const Icon(Icons.arrow_drop_down_rounded,size: 30,)
              ),
            ],
          ),
          Visibility(
            visible: isExtended,
            child: Column(
              children: [
                billItemTile(widget.w, widget.h,"Items Total",data?.totalAmount,),
                billItemTile(widget.w, widget.h,"Delivery fee",data?.deliveryFee,),
                billItemTile(widget.w, widget.h,data?.couponCode,"-50",),
              ],
            )
          )
        ],
      ),
      
    );
  }
}


Widget itemTile(w,h,productName,value,price){
  return Container(
    width: w,
    height: h * 0.02,
    margin: EdgeInsets.all(2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${productName} x ${value}",style:TextStyle(color: Colors.grey),),
        Text("₹ ${price}",style:TextStyle(color: const Color.fromARGB(255, 87, 87, 87)),),
      ],
    ),
  );
}

Widget billItemTile(w,h,name,amount){
  return Container(
    width: w,
    height: h * 0.02,
    margin: EdgeInsets.all(2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("${name}",style:TextStyle(color: Color.fromARGB(255, 88, 88, 88),fontSize: 12),),
        Text("₹ ${amount}",style:TextStyle(color: const Color.fromARGB(255, 87, 87, 87)),),
      ],
    ),
  );
}



