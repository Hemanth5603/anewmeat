import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/cart_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController{

  List<dynamic> cartList = [].obs;
  CartModel? cartModel;
  CartModel? getCartModel;
  bool isCartEmpty = true;
  var isLoading = false.obs;

  Future addToCart(productName,productImage,originalPrice,finalPrice,quantity,value)async{
    try{
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.saveToCart);

      final headers = {
        "name":"Hemanth",
        "number": "7997435603",
        "email": "shemanth.kgp@gmail.com",
      };

      final body = {
        "productName": productName,
        "finalPrice": finalPrice,
        "originalPrice": originalPrice,
        "productImage":productImage,
        "quantity": quantity,
        "value": "1"

      };
      var response = await http.post(uri,headers: headers,body:body);
      print(response.statusCode);
      if(response.statusCode == 200 && response.body != null){
        var data = jsonDecode(response.body.toString());
        print(data);
        cartModel = CartModel.fromJson(data);
      }else{
        print("Error Fetching Products Data");
      }
    }catch(e){
      print('Error while getting data $e');
    }
  }


  Future getCartItems() async{
    try{
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getCart);
      final body  = {
        "number":"7997435603"
      };
      isLoading(true);
      var response = await http.post(uri,body:body);
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        getCartModel = CartModel.fromJson(data);
      }else{
        print("Error Fetching Products Data");
      }
      print(getCartModel?.items?.length);
      isLoading(false);
    }catch(e){
      print("Cannot fetch cart items $e");
    }

  }
}