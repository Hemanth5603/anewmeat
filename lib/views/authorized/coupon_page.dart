import 'package:anewmeat/controllers/coupon_controller.dart';
import 'package:anewmeat/views/widgets/coupon_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({super.key});

  @override
  State<CouponPage> createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {

  @override
  void initState() {
    super.initState();
    couponController.getCoupons();
  }
  CouponController couponController = Get.put(CouponController());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 245, 250),
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_rounded ,color: Colors.black,),
        backgroundColor: Colors.white,
        title:const Text("Apply Coupon",style: TextStyle(fontFamily:'poppins',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
      ),
      body: SafeArea(
        child: Container(
          padding:const EdgeInsets.all(12),
          width: w,
          height: h,
            child:Obx(() => couponController.isLoading.value 
             ? const Center(
              child: CircularProgressIndicator(),
             ) 
             : ListView.builder(
              itemCount: couponController.couponModel?.coupons.length,
              itemBuilder: (context,index){
                return CouponCard(
                  w:w,
                  h:h,
                  name: couponController.couponModel?.coupons[index].name ?? " ",
                  code: couponController.couponModel?.coupons[index].code ?? " ",
                  conditions: couponController.couponModel?.coupons[index].conditions,
                  
                );
              },
            )   
            ),
          ),
        ),
    );
  }
}

