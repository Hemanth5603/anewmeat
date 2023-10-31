import 'dart:convert';

import 'package:get/get_rx/get_rx.dart';
import 'package:http/http.dart' as http;

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/banner_model.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';


class BannersController extends GetxController{

  BannerModel? bannerModel;
  var isLoading = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanners();

  }

  void getBanners() async{
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getBanners);
      final headers = {'Content-Type': 'application/json'};

      var response = await http.get(uri,headers: headers);
   
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        bannerModel = BannerModel.fromJson(data);
      }else{
        print("Error Fetching Data");
      } 
    }catch (e) {
      print('Error while getting data is $e');
    }
    isLoading(false);

  }

  

}