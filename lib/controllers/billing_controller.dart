import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/models/coupon_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BillingController extends GetxController{


  CouponModel? couponModel;
  var isLoading = false.obs;
  double totalAmount = 0.0.obs();
  double discount = 0.0.obs();
  CartController cartController = Get.put(CartController());


  Future<void> getCoupons() async {
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getCoupons);
      var response = await http.get(uri);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        couponModel = CouponModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error while Fetching Coupons: ");
      }
    }catch(e){
      if(kDebugMode){
        print("Error $e");
      }
    }finally{
      isLoading(false);
    }
  }

  Future<void> getOrders() async{
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getOrders);
      var response = await http.get(uri);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        // save the data
      }else{
        if(kDebugMode) print("Error while fetching orders");
      }
    }catch(e){
      if(kDebugMode){
        print("Error $e");
      }
    }finally{
      isLoading(false);
    }
  }

  double calculateTotalAmount(){
    double total = 0;
    
    for(int i = 0; i < cartController.getCartModel!.products[0].items.length;i++){
      total += double.parse(cartController.getCartModel!.products[0].items[i].finalPrice);
    }
    cartController.getCartModel?.totalAmount = total - discount;
    totalAmount = total - discount;
    return total - discount;
  }

  double applyCoupon(index){

    double total = totalAmount;
    double discountAmount = 0.0;

    if(total >= int.parse(couponModel!.coupons[index].minAmount)){
      if(couponModel!.coupons[index].applyForFirstOrder == "Y"){ //add is first oder parameter
        discountAmount = (int.parse(couponModel!.coupons[index].discount)/100) * total;
        if(discountAmount > int.parse(couponModel!.coupons[index].maxAmount)){
          print(discountAmount);
          discount = double.parse(couponModel!.coupons[index].maxAmount);
          return discountAmount;
        }else{
          print(discountAmount);
          discount = discountAmount;
          return discountAmount;
        }
      }
    }
    return discountAmount;
  }
  
}