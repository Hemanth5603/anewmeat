import 'dart:convert';
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/user_controller.dart';
import 'package:anewmeat/models/bill_model.dart';
import 'package:anewmeat/models/cart_model.dart';
import 'package:anewmeat/views/authorized/tabs/account/orders/orders_page.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile/edit_profile.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile_page.dart';
import 'package:anewmeat/views/utils/no_orders_page.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:anewmeat/models/coupon_model.dart';
import 'package:anewmeat/models/order_model.dart' hide Items;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BillingController extends GetxController{
  OrderModel? orderModel;
  CouponModel? couponModel;
  BillModel? billModel;
  var isLoading = false.obs;
  bool loading = false;
  double totalAmount = 0.0.obs();
  double discount = 0.0.obs();
  late Razorpay razorpay;
  CartController cartController = Get.put(CartController());
  UserController userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,handlePaymentSucess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,handlepaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,handleExternalWallet);
  }

  @override
  void dispose(){
    super.dispose();
    razorpay.clear;
  }

  
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
        print("Error fetching coupons --  $e");
      }
    }finally{
      isLoading(false);
    }
  }

  


  Future<void> createOrder() async{
    DateTime now = DateTime.now();
    String formattedOrderID = DateFormat('yyyyMMddHHmmss').format(now);
    String time = DateFormat("HH:mm:ss").format(now);
    String date = DateFormat("dd:MM:yyyy").format(now);
    String orderID = 'ORD_$formattedOrderID';

    isLoading(true);
    try{
      await userController.getCurrentLocation();
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.createOrder);
      List<Map<String, dynamic>> itemsJson = cartController.getCartModel!.products[0].items.map((item) => item.toJson()).toList();
    
      print(json.encode(cartController.getCartModel?.products[0].items));
      print(orderID.toString());
     
      Map<String,dynamic> body = {
        "order_id":orderID.toString(),
        "name":userController.userModel.name.toString(),
        "number":userController.userModel.number.toString(),
        "date":date.toString(),
        "time":time.toString(),
        "items":jsonEncode(cartController.getCartModel?.products[0].items),
        "total_amount":billingController.billModel?.toPay.toString(),
        "payment_method":"UPI",
        "coupon_code" :"DIWALI10",
        "delivery_fee":billingController.billModel?.deliveryFees.toString(),
        "delivery_address":userController.userModel.address.toString(),
        "order_accepted":false.toString(),
        "out_for_delivery":false.toString(),
        "order_delivered":false.toString(),
        "delivery_latitude":userController.userModel.latitude.toString(),
        "delivery_longitude":userController.userModel.longitude.toString(),
        "admin_latitude":17.725028.toString(),
        "admin_longitude":83.303416.toString(),
        "delivery_person_phone":"7001189227",
      };
      
      try{
        var response = await post(uri,body:body);
        print(response.statusCode);
        if(response.statusCode == 200){
          if(kDebugMode) print(response.body);
          print("Created order in DB-------------");
        }else{
          if(kDebugMode) print("Cannot save order");
        }
      }catch(e){
        print("error saving order");
        if(kDebugMode) print(e);
      }

      isLoading(false);

      

    }catch(e){
      if(kDebugMode) print("error: $e");
      if(kDebugMode) print("cannot insert Orders");
    }

  }

  List<Map<String, dynamic>> itemsToJson(List<Items> items) {
    return items.map((item) => item.toJson()).toList();
  }




  Future<void> getOrders() async{
    try{
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final headers = {
        "number":prefs.getString("phone")!,
      };
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getOrders);
      var response = await http.get(uri,headers: headers);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        orderModel = OrderModel.fromJson(data);
        print(response.body);
      }else{
        if(kDebugMode) print("Error while fetching orders");
      }
      print(orderModel?.orders.length);
      
      /*if(orderModel!.orders.isEmpty){
        Get.to(const NoOrdersPage());
      }*/
    }catch(e){
      if(kDebugMode){
        print("Error fetching orders $e");
      }
    }finally{
      isLoading(false);
      
    }
  }

  Future<void> checkCoupon(code) async{
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.checkCoupon);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final body = {
        "number":prefs.getString("phone")!,
        "code":code.toString()
      };
      var response = await http.post(uri,body: body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        billModel = BillModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error while Applying Coupon and fetcing bill ");
      }
    }catch(e){
      if(kDebugMode){
        print("Error applying coupon and fetching bill -- $e");
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


  void openCheckout() async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    int payableAmount = billingController.billModel!.toPay;
    payableAmount = payableAmount * 100;
    var options = {
      'key' : 'rzp_test_L9eApwy7Hv77Xf',
      'amount': payableAmount,
      'name': prefs.getString("name"),
      'prefill': {
        'contact': prefs.getString("phone"),
        'email': prefs.getString("email"),
        'external':{
          'wallets': ['paytm',"phonepe"]
        }
      }
    };
    try{
      razorpay.open(options);
    }catch(e){
      debugPrint('error : $e');
    }
  }

  void handlePaymentSucess(PaymentSuccessResponse response){
    print("Payment Sucess ----- : ${response.paymentId}");
  }

  void handlepaymentError(PaymentFailureResponse response){
    print("Payment fail ----- : ${response.message}");
  }

  void handleExternalWallet(ExternalWalletResponse response){
    print("External Wallet ----- : ${response.walletName}");
  }


  




}



