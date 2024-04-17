import 'dart:convert';
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/cart_model.dart';
import 'package:anewmeat/models/cart_response.dart';
import 'package:anewmeat/views/authorized/tabs/account/orders/orders_page.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController{

  List<dynamic> cartList = [].obs;
  CartModel? cartModel,getCartModel,deleteCartModel,updateCartModel;
  CartResponse? cartResponse;
  bool isCartEmpty = true;
  List<dynamic> totalCartItems = [].obs;
  var isLoading = false.obs;
  var isCalculating = false.obs;
  int cartItemsLength = 0;
  var totalItemsLength = 0.obs;
  

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }


  Future addToCart(id,productName,productImage,originalPrice,finalPrice,quantity,value)async{
    try{
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.saveToCart);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      final headers = {
        "name":prefs.getString("name")!,
        "number": prefs.getString("phone")!,
        "email": prefs.getString("email")!,
      };
      final body = {
        "id": id,
        "productName": productName,
        "finalPrice": finalPrice,
        "originalPrice": originalPrice,
        "productImage":productImage,
        "oPrice": originalPrice,
        "fPrice": finalPrice,
        "quantity": quantity,
        "value": "1"
      };

      var response = await http.post(uri,headers: headers,body:body);
      if(kDebugMode) print(response.statusCode);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        if(kDebugMode)print(data);
        cartResponse = CartResponse.fromJson(data);
      }else{
        if(kDebugMode)print("Error Fetching Products Data");
      }
      int cartLength  = getCartModel!.products[0].items.length +1;
      prefs.setString("_cartLength", cartLength.toString());    
    }catch(e){
      if(kDebugMode)print('Error addtoCart API $e');
    }
  }


  Future<void> getCartItems() async{
    try{
      isLoading(true);
      isCalculating(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getCart);
      print(prefs.getString("phone"));
      final headers = {
        "number":prefs.getString("phone")!
      };
      var response = await http.get(uri,headers: headers);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        getCartModel = CartModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error Fetching Cart Items data");
      }
      /*totalItemsLength(getCartModel!.products[0].items.length);
      if(getCartModel!.products.isEmpty){
        totalCartItems.add("0");
      }else{
        prefs.setString("_cartLength",getCartModel!.products[0].items.length.toString());
        totalCartItems.add(prefs.getString("_cartLength"));
      }*/
      isLoading(false);
      isCalculating(false);
    }catch(e){
      if(kDebugMode) print("Cannot fetch cart items $e");
    }finally{
      
    }
  }

  Future deleteCartItem(id) async{
    try{
      isLoading(true);
      billingController.isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.deleteCart);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      final headers = {
        "number":prefs.getString("phone")!,
      };
      final body = {
        "id":id,
      };
      var response = await http.post(uri,headers: headers,body: body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        cartResponse = CartResponse.fromJson(data);
      }else{
        if(kDebugMode) print("Error while Deleting Item");
      }
       if(kDebugMode) print(response.body);
    }catch(e){
      if(kDebugMode){
        print("Error deletecartitemAPI $e");
      }
    }finally{
      isLoading(false);
      billingController.isLoading(false);
    }
  }



  Future<void> incrementCartItemValue(id,index,originalPrice,finalPrice) async{
    getCartModel!.products[0].items[index].value = getCartModel!.products[0].items[index].value! + 1 ;
    int oPrice = int.parse(getCartModel!.products[0].items[index].originalPrice);
    int fPrice = int.parse(getCartModel!.products[0].items[index].finalPrice);
    oPrice += int.parse(originalPrice);
    fPrice += int.parse(finalPrice);
    getCartModel!.products[0].items[index].originalPrice = oPrice.toString();
    getCartModel!.products[0].items[index].finalPrice = fPrice.toString();

    try{
      isCalculating(true);
      billingController.isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.updateCart);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final headers = {
        "number":prefs.getString("phone")!
      };
      
      final body = {
        "id": id,
        "value": getCartModel!.products[0].items[index].value.toString(),
        "finalPrice": fPrice.toString(),
        "originalPrice": oPrice.toString(),
      };
      var response = await http.post(uri,headers: headers,body: body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        updateCartModel = CartModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error while incrementing Item value");
      }
      if(kDebugMode) print(response.body);
    }catch(e){
      if(kDebugMode){
        print("Error $e");
      }
    }finally{
      isCalculating(false);
      billingController.isLoading(false);
    }
  }


  Future<void> decrementCartItemValue(id,index,originalPrice,finalPrice) async{
    getCartModel!.products[0].items[index].value = getCartModel!.products[0].items[index].value! - 1;
    int oPrice = int.parse(getCartModel!.products[0].items[index].originalPrice);
    int fPrice = int.parse(getCartModel!.products[0].items[index].finalPrice);
    oPrice -= int.parse(originalPrice);
    fPrice -= int.parse(finalPrice);
    getCartModel!.products[0].items[index].originalPrice = oPrice.toString();
    getCartModel!.products[0].items[index].finalPrice = fPrice.toString();
    try{
      isCalculating(true);
      billingController.isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.updateCart);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final headers = {
        "number":prefs.getString("phone")!
      };
      final body = {
        "id": id,
        "value": getCartModel!.products[0].items[index].value.toString(),
        "finalPrice": fPrice.toString(),
        "originalPrice": oPrice.toString(),
      };
      var response = await http.post(uri,headers: headers,body: body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        updateCartModel = CartModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error while decrementing Item value");
      }
       if(kDebugMode) print(response.body);
    }catch(e){
      if(kDebugMode){
        print("Error $e");
      }
    }finally{
      isCalculating(false);
      billingController.isLoading(false);
    }
  }


  int getCartLength(){
    isLoading(true);
    int len = getCartModel!.products[0].items.length;
    isLoading(false);
    cartItemsLength = len;
    return len;
  }
 


}