

import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController{

  var isLoading = false.obs;

  ProductModel? productModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getProducts);
      final headers = {'Content-Type': 'application/json'};

      var response = await http.get(uri,headers: headers);
   
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        productModel = ProductModel.fromJson(data);
      }else{
        print("Error Fetching Products Data");
      } 
    }catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

}