import 'dart:convert';

import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/models/user_model.dart';
import 'package:anewmeat/views/authentication/otp.dart';
import 'package:anewmeat/views/authentication/signup.dart';
import 'package:anewmeat/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';


class AuthController extends GetxController{

  var userModelList = <UserModel>[].obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();


  void sendOtp(){
    Get.to(const OTP(),transition: Transition.rightToLeft,duration: 300.milliseconds);
    print("call back");
  }

  void verifyOtp(){
    Get.to(const Home(),transition: Transition.rightToLeft,duration: 300.milliseconds);
  }

  void register() async {
    print("Clicked");
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

    Get.to(const Home(),transition: Transition.rightToLeft,duration: 300.milliseconds);
  }
}