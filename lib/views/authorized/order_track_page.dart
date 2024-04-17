import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:googleapis/cloudsearch/v1.dart';

class OrderTrack extends StatefulWidget {
  const OrderTrack({
    super.key,
    required this.orderDate,
    required this.orderID,
    required this.estimatedDelivery,
    required this.isOrderConfirmed,
    required this.orderDelivered,
    required this.outForDelivery,
  });
  final String? orderID;
  final String? orderDate;
  final String? estimatedDelivery;
  final bool? isOrderConfirmed;
  final bool? outForDelivery;
  final bool? orderDelivered;


  @override
  State<OrderTrack> createState() => _OrderTrackState();
}

class _OrderTrackState extends State<OrderTrack> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar:  GestureDetector(
        onTap: (){
          Get.back();
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.05,
          decoration: BoxDecoration(
             color: Colors.white,
             border: Border.all(color: Constants.customRed,width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Go to Orders",style: TextStyle(fontSize: 18,color: Constants.customRed),),
                const SizedBox(width: 6,),

              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        title: const Text("Track My Order",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: w,
              height: h * 0.13,
              color: Color.fromARGB(255, 255, 255, 255),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order ID:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                          Text(widget.orderID.toString(),style: TextStyle(fontSize: 14,color: const Color.fromARGB(255, 60, 60, 60)),)
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Order Date:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                          Text(widget.orderDate.toString(),style: TextStyle(fontSize: 14,color: const Color.fromARGB(255, 60, 60, 60)),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Estimated Delivery: ",style: TextStyle(fontSize: 16,color: Constants.customGreen),),
                      Text(widget.estimatedDelivery.toString(),style: TextStyle(fontSize: 16,color: Constants.customGreen),)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              width: w,
              height: h * 0.65,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50,50,0,0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:widget.isOrderConfirmed! ? Constants.customGreen : Colors.grey
                              ),
                            ),
                            Container(
                              width: 5,
                              height: 80,
                              color:widget.outForDelivery! || widget.orderDelivered! ? Constants.customGreen:  Colors.grey,
                            )
                          ],
                        ),
                        const SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Confirmed",style: TextStyle(
                              fontSize: 16,
                              color:widget.outForDelivery! || widget.orderDelivered! ? Constants.customGreen : Colors.grey,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 3,),
                            Text("March 09, 2024, 19:30 PM",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:widget.outForDelivery! || widget.orderDelivered! ? Constants.customGreen : Colors.grey,
                              ),
                            ),
                            Container(
                              width: 5,
                              height: 80,
                              color: widget.orderDelivered! ? Constants.customGreen : Colors.grey,
                            )
                          ],
                        ),
                        const SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Out for Delivery",style: TextStyle(
                              fontSize: 16,
                              color: widget.outForDelivery! || widget.orderDelivered! ? Constants.customGreen : Colors.grey,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(height: 3,),
                            Text("March 09, 2024, 19:30 PM",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:widget.orderDelivered! ? Constants.customGreen : Colors.grey,
                              ),
                            ),
                            
                          ],
                        ),
                        const SizedBox(width: 30,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Order Delivered",style: TextStyle(
                              fontSize: 16,
                              color: widget.orderDelivered! ? Constants.customGreen : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),),
                            SizedBox(height: 3,),
                            Text("March 09, 2024, 19:30 PM",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}