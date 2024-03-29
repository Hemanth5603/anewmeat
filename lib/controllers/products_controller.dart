import 'dart:convert';
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/models/product_category_model.dart';
import 'package:anewmeat/models/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController{

  RxBool isLoading = false.obs;
  var categoryName = "";
  ProductModel? productModel,searchModel,offersProductModel;
  ProductCategoryModel? productCategoryModel;
  CartController cartController = Get.put(CartController());



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
        searchModel = ProductModel.fromJson(data);
        for(int i = 0;i < productModel!.products.length;i++ ){
          for(int j = 0;j< cartController.getCartModel!.products[0].items.length;j++){
            if(productModel!.products[i].id == cartController.getCartModel!.products[0].items[j].id){
              productModel!.products[i].isAdded = true;
              searchModel!.products[i].isAdded = true;
            }
          }
        }
      }else{
        if(kDebugMode) print("Error Fetching Products Data");
      } 
    }catch (e) {
      if(kDebugMode) print('Error fetching AllProductsAPI --  $e');
    } finally {
      isLoading(false);
    }
  }




  Future<void> fetchCategoryProducts() async{
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl +APIConstants.getProducts);

      final body = {
        "categorieName": categoryName.toLowerCase()
      };
      var response = await http.post(uri,body: body);

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        productCategoryModel = ProductCategoryModel.fromJson(data);
        for(int i = 0;i < productCategoryModel!.categoryProducts.length;i++ ){
          for(int j = 0;j< cartController.getCartModel!.products[0].items.length;j++){
            if(productCategoryModel!.categoryProducts[i].id == cartController.getCartModel!.products[0].items[j].id){
              productCategoryModel!.categoryProducts[i].isAdded = true;
            }
          }
        }
        isLoading(false);
      }else{
        if(kDebugMode) print("Error Fetching specific products");
      }
    }catch(e){
      if(kDebugMode) print("$e");
    }finally{
      
    }
  }
}