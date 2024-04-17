import 'dart:convert';
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/user_controller.dart';
import 'package:anewmeat/models/bill_model.dart';
import 'package:anewmeat/views/authorized/tabs/account/orders/orders_page.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile/edit_profile.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile_page.dart';
import 'package:anewmeat/views/utils/no_orders_page.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:anewmeat/models/coupon_model.dart';
import 'package:anewmeat/models/order_model.dart';
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
      final ref = FirebaseFirestore.instance
        .collection("orders").doc();
        await ref.set({
          "_id":1,
          "uid":ref.id,
          "order_id":orderID,
          "name":"Hemanth",
          "number":7997435603,
          "date": date,
          "time":time,
          "totalAmount":billingController.billModel?.toPay,
          "payment_method":"UPI",
          "coupon_code":"DIWALI10",
          "delivery_fee":billingController.billModel?.deliveryFees,
          "delivery_address":userController.userModel.address.toString(),
          "is_delivered": false,
          "out_for_delivery": false,
          "order_recieved": false,
          "timestamp":FieldValue.serverTimestamp(),
        });

          

      for(int i=0;i< cartController.getCartModel!.products[0].items.length; i++){
        final itemsRef = FirebaseFirestore.instance
        .collection("orders")
        .doc(ref.id)
        .collection("items")
        .doc();

        await itemsRef.set({
          "id": cartController.getCartModel?.products[0].items[i].id,
          "productName": cartController.getCartModel?.products[0].items[i].productName,
          "finalPrice": cartController.getCartModel?.products[0].items[i].finalPrice,
          "originalPrice": cartController.getCartModel?.products[0].items[i].originalPrice,
          "productImage": cartController.getCartModel?.products[0].items[i].productImage,
          "quantity": cartController.getCartModel?.products[0].items[i].quantity,
          "value": cartController.getCartModel?.products[0].items[i].value.toString(),
          "fPrice": cartController.getCartModel?.products[0].items[i].fPrice,
          "oPrice": cartController.getCartModel?.products[0].items[i].oPrice,
        });
      }

      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.saveOrder);
      
      print("Products =-----------------------------------");
      print(json.encode(cartController.getCartModel?.products[0].items));
      Map<String,dynamic> body = {
        "uId":ref.id.toString(),
        "order_id":orderID.toString(),
        "name":userController.userModel.name.toString(),
        "number":userController.userModel.number.toString(),
        "date":date.toString(),
        "time":time.toString(),
        "items":json.encode(cartController.getCartModel?.products[0].items),   
        "totalAmount":billingController.billModel?.toPay.toString(),
        "payment_method":"UPI",
        "coupon_code" :"DIWALI10",
        "delivery_fee":billingController.billModel?.deliveryFees.toString(),
        "delivery_address":userController.userModel.address.toString(),
      };
      try{
        var response = await post(uri,body:body);
        print(response.statusCode);
        if(response.statusCode == 200){
          if(kDebugMode) print(response.body);
          print("Created order in DB");
        }else{
          if(kDebugMode) print("Cannot save order");
        }
      }catch(e){
        print("error saving order");
        if(kDebugMode) print(e);
      }

      isLoading(false);

      print("Order successfully --------------------------////////");

    }catch(e){
      if(kDebugMode) print("error: $e");
      if(kDebugMode) print("cannot insert Orders");
    }

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


  void openCheckout(amount) async{
    amount = amount * 100;
    var options = {
      'key' : 'rzp_test_L9eApwy7Hv77Xf',
      'amount': amount,

      
      'name': 'Hemanth',
      'prefill': {
        'contact': '7997435603',
        'email': 'shemanth.kgp@gmail.com',
        'external':{
          'wallets': ['paytm']

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



