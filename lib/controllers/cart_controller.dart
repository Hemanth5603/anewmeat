import 'dart:convert';
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/cart_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController{

  List<dynamic> cartList = [].obs;
  CartModel? cartModel,getCartModel,deleteCartModel,updateCartModel;
  bool isCartEmpty = true;
  List<dynamic> totalCartItems = [].obs;
  var isLoading = false.obs;
  var isCalculating = false.obs;
  //double totalAmount = 0.0;
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
        "name":"Hemanth",
        "number": "7997435603",
        "email": "shemanth.kgp@gmail.com",
      };
      final body = {
        "id": id,
        "productName": productName,
        "finalPrice": finalPrice,
        "originalPrice": originalPrice,
        "productImage":productImage,
        "quantity": quantity,
        "value": "1"
      };

      var response = await http.post(uri,headers: headers,body:body);
      if(kDebugMode) print(response.statusCode);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        if(kDebugMode)print(data);
        cartModel = CartModel.fromJson(data);
      }else{
        if(kDebugMode)print("Error Fetching Products Data");
      }
      int cartLength  = getCartModel!.products[0].items.length +1;
      prefs.setString("_cartLength", cartLength.toString());    
    }catch(e){
      if(kDebugMode)print('Error while getting data $e');
    }
  }


  Future<void> getCartItems() async{
    try{
      isLoading(true);
      isCalculating(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getCart);
      final headers = {
        "number":"7997435603"
      };
      var response = await http.get(uri,headers: headers);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        getCartModel = CartModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error Fetching Products Data");
      }
      totalItemsLength(getCartModel!.products[0].items.length);
      if(getCartModel!.products.isEmpty){
        totalCartItems.add("0");
      }else{
        prefs.setString("_cartLength",getCartModel!.products[0].items.length.toString());
        totalCartItems.add(prefs.getString("_cartLength"));
      }
    }catch(e){
      if(kDebugMode) print("Cannot fetch cart items $e");
    }finally{
      isLoading(false);
      isCalculating(false);
    }
  }

  Future deleteCartItem(id) async{
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.deleteCart);
      final headers = {
        "number":"7997435603"
      };
      final body = {
        "id":id,
      };
      var response = await http.post(uri,headers: headers,body: body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        deleteCartModel = CartModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error while Deleting Item");
      }
       if(kDebugMode) print(response.body);
    }catch(e){
      if(kDebugMode){
        print("Error $e");
      }
    }finally{
      isLoading(false);
    }
  }



  Future incrementCartItemValue(id,index,originalPrice,finalPrice) async{
    getCartModel!.products[0].items[index].value = getCartModel!.products[0].items[index].value! + 1 ;
    int oPrice = int.parse(getCartModel!.products[0].items[index].originalPrice);
    int fPrice = int.parse(getCartModel!.products[0].items[index].finalPrice);
    oPrice += int.parse(originalPrice);
    fPrice += int.parse(finalPrice);
    getCartModel!.products[0].items[index].originalPrice = oPrice.toString();
    getCartModel!.products[0].items[index].finalPrice = fPrice.toString();
    try{
      isCalculating(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.updateCart);
      final headers = {
        "number":"7997435603"
      };
      final body = {
        "id": id,
        "value": getCartModel!.products[0].items[index].value.toString()
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
    }
  }


  Future decrementCartItemValue(id,index,originalPrice,finalPrice) async{
    getCartModel!.products[0].items[index].value = getCartModel!.products[0].items[index].value! - 1;
    int oPrice = int.parse(getCartModel!.products[0].items[index].originalPrice);
    int fPrice = int.parse(getCartModel!.products[0].items[index].finalPrice);
    oPrice -= int.parse(originalPrice);
    fPrice -= int.parse(finalPrice);
    getCartModel!.products[0].items[index].originalPrice = oPrice.toString();
    getCartModel!.products[0].items[index].finalPrice = fPrice.toString();
    try{
      isCalculating(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.updateCart);
      final headers = {
        "number":"7997435603"
      };
      final body = {
        "id":id,
        "value":getCartModel!.products[0].items[index].value.toString()
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