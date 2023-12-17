import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';


class CategoryController extends GetxController{
  var isLoading = false.obs;
  bool isPageLoading = false;

  CategoryModel? categoryModel;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories()async {

    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getCategories);
      final headers = {'Content-Type': 'application/json'};

      var response = await http.get(uri,headers: headers);
   
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        categoryModel = CategoryModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error Fetching Data");
      } 
    }catch (e) {
      if(kDebugMode) print('Error while getting data is $e');
    } finally {
      isLoading(false);
      isPageLoading = true;
    }

  }
}




