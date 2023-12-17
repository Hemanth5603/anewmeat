import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/coupon_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CouponController extends GetxController{


  CouponModel? couponModel;
  var isLoading = false.obs;


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
}