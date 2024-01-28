import 'dart:convert';
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/models/bill_model.dart';
import 'package:anewmeat/models/coupon_model.dart';
import 'package:anewmeat/models/order_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';


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

  Future<void> getOrders() async{
    try{
      isLoading(true);
      loading = true;
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getOrders);
      var response = await http.get(uri);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        orderModel = OrderModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error while fetching orders");
      }
    }catch(e){
      if(kDebugMode){
        print("Error fetching orders $e");
      }
    }finally{
      isLoading(false);
      loading = false;
    }
  }

  Future<void> checkCoupon(code) async{
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.checkCoupon);
      final body = {
        "number":"7997435603",
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



