import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/user_model.dart';
import 'package:anewmeat/views/authentication/otp.dart';
import 'package:anewmeat/views/authorized/location.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/home.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';


class UserController extends GetxController{

  var userModelList = <UserModel>[].obs;
  Rx<UserModel> userModel = UserModel().obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  void sendOtp(){
    Get.to(const OTP(),transition: Transition.rightToLeft,duration: 300.milliseconds);
    print("call back");
  }

  void verifyOtp(){
    Get.to(const LocationScreen(),transition: Transition.rightToLeft,duration: 300.milliseconds);
  }

  void register() async {
    final uri = Uri.parse(APIConstants.baseUrl + APIConstants.register);
    final headers = {'Content-Type': 'application/json'};
    Map<String,dynamic> body = {
      "name":"S.Ganesh",
      "number":"7997435603",
      "email":"saiGanesh@gmail.com",
    };
    String jsonBody = jsonEncode(body);
    var response = await post(
      uri,
      body: body,
    );
    int statusCode = response.statusCode;
    print(statusCode);
    userModelList.value = productFromJson(response.body);
    print(statusCode);
    print(userModelList[0].email);
    print(userModelList[0].id);

    Get.to(const HomePage(),transition: Transition.rightToLeft,duration: 300.milliseconds);
  }


  Future<void> getCurrentLocation() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Please keep your location enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print('Location Permission denied!');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print('Location Permission denied Forever!');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      print(position.latitude);

      userModel.value.latitute = position.latitude;
      userModel.value.longitude = position.longitude;
      userModel.value.address ="${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
      // =  "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
    } catch (e) {
      print(e);
    }
  }

}



