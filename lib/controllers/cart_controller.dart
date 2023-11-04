import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController{

  List<String> cartList = [];
  CartModel? cartModel;


  Future addToCart(productName,productImage,originalPrice,finalPrice,quantity,value)async{
    try{
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.saveToCart);

      final headers = {
        "Content-Type": "application/json",
        "name":"Hemanth",
        "number": "7997435603",
        "email": "shemanth.kgp@gmail.com",
      };

      final body = {
        "productName": productName,
        "categorieName": "chicken",
        "finalPrice": finalPrice,
        "originalPrice": originalPrice,
        "productImage":productImage,
        "quantity": quantity,
        "value":value
      };
      var response = await http.post(uri,headers: headers,body:body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        cartModel = CartModel.fromJson(data);
      }else{
        print("Error Fetching Products Data");
      }
    }catch(e){
      print('Error while getting data is $e');

    }
  }



  Future getCartItems() async{
    try{
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getCart);

      final body  = {
        "number":"7997435603"
      };

      var response = await http.post(uri,body:body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        cartModel = CartModel.fromJson(data);
      }else{
        print("Error Fetching Products Data");
      }
    }catch(e){
      print("Cannot fetch cart items $e");
    }
  }
}