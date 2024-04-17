


import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/billing_controller.dart';
import 'package:anewmeat/views/authorized/order_track_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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

  bool isExtended = false;
  bool isDataExtended = false;
  late double cHeight = widget.h * widget.billingController.orderModel!.orders[0].items.length * 0.122;
  @override
  Widget build(BuildContext context) {
    
  
    return AnimatedContainer(
      duration:const Duration(milliseconds: 200),
      width: widget.w,
      height: cHeight,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(111, 189, 189, 189),
            blurRadius: 10
          )
        ],
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order ID: ${widget.billingController.orderModel?.orders[0].orderId}",style: const TextStyle(fontFamily: 'poppins',color: Colors.grey,fontSize: 12),),
              GestureDetector(
                child: Text("Track Order",style: TextStyle(fontSize: 14,color: Constants.customRed,fontWeight: FontWeight.bold),),
                onTap: (){
                    Get.to(
                      OrderTrack(
                        orderDate: widget.billingController.orderModel!.orders[0].date, 
                        orderID: widget.billingController.orderModel!.orders[0].orderId, 
                        estimatedDelivery: "18-04-2024", 
                        isOrderConfirmed: true,  
                        outForDelivery: true,
                        orderDelivered: false,
                    ),
                    transition: Transition.rightToLeft,
                    duration: 300.milliseconds
                  );
                }
              ),
            ],
          ),
          const SizedBox(height: 2,),
          Text("${widget.billingController.orderModel?.orders[0].date} | ${widget.billingController.orderModel?.orders[0].time}",style: const TextStyle(fontFamily: 'poppins',color: Color.fromARGB(255, 110, 110, 110),fontSize: 12),),
          const SizedBox(height: 10,),
          const Text("Ordered Items",style: TextStyle(fontFamily: 'poppins',color: Color.fromARGB(255, 0, 0, 0),fontSize: 14,fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          SizedBox(
            width: widget.w,
            height: widget.h * widget.billingController.orderModel!.orders[0].items.length * 0.04,
            child: ListView.builder(
              itemCount: widget.billingController.orderModel!.orders[0].items.length,
              itemBuilder: (context,index){
                return itemTile(
                  widget.w,
                  widget.h,
                  widget.billingController.orderModel?.orders[0].items[index].productName,
                  widget.billingController.orderModel?.orders[0].items[index].value,
                  widget.billingController.orderModel?.orders[0].items[index].finalPrice
                );
              },
            ),
          ),
          Container(
            width: widget.w,
            height: 1,
            color: Color.fromARGB(255, 231, 231, 231),
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
                      cHeight = widget.h *  widget.billingController.orderModel!.orders[0].items.length * 0.125;
                      isExtended = false;
                      isDataExtended = false;
                    }
                    else{
                      cHeight = widget.h * widget.billingController.orderModel!.orders[0].items.length * 0.17;
                      Future.delayed(Duration(milliseconds: 200), () {
                        setState(() {
                          isDataExtended = true;
                        });
                      });
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
            visible: isDataExtended,
            child: Column(
              children: [
                billItemTile(widget.w, widget.h,"Items Total",widget.billingController.orderModel?.orders[0].totalAmount,),
                billItemTile(widget.w, widget.h,"Delivery fee",widget.billingController.orderModel?.orders[0].deliveryFee,),
                billItemTile(widget.w, widget.h,widget.billingController.orderModel?.orders[0].couponCode,"-50",),
              ],
            )
          ),
         
        ],
      ),
    );
  }
}


Widget itemTile(w,h,productName,value,price){
  return Container(
    width: w,
    height: h * 0.02,
    margin:const EdgeInsets.all(2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Text("$productName x $value",style:TextStyle(color: Constants.customRed),),
        Text("₹ $price",style:const TextStyle(color: Color.fromARGB(255, 87, 87, 87)),),
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
        Text("$name",style:TextStyle(color: Color.fromARGB(255, 88, 88, 88),fontSize: 12),),
        Text("₹ $amount",style:TextStyle(color: const Color.fromARGB(255, 87, 87, 87)),),
      ],
    ),
  );
}