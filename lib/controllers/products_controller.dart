

import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/product_category_model.dart';
import 'package:anewmeat/models/product_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController{

  var isLoading = false.obs;
  var categoryName = "";
  ProductModel? productModel;
  ProductCategoryModel? productCategoryModel;


  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getProducts);

      var response = await http.get(uri,headers: APIConstants.headers);
   
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




  Future<void> fetchCategoryProducts() async{
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl +APIConstants.getProducts);

      final body = {
        "categorieName":categoryName
      };

      var response = await http.post(uri,body: body);

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        productCategoryModel = ProductCategoryModel.fromJson(data);
        print(data);
      }else{
        print("Error Fetching specific products");
      }
    }catch(e){
      print("$e");
    }finally{
      isLoading(false);
    }
  }


}