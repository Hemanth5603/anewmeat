import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class CategoryController extends GetxController{
  var isLoading = false.obs;

  CategoryModel? categoryModel;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  void fetchCategories()async {

    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getCategories);
      final headers = {'Content-Type': 'application/json'};

      var response = await http.get(uri,headers: headers);
   
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        categoryModel = CategoryModel.fromJson(data);
      }else{
        print("Error Fetching Data");
      } 
    }catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }

    

    /*if(response.statusCode == 200){
      return CategoryModel.fromJson(data);
    }else{
      return CategoryModel.fromJson(data);
    }*/
  }
}




