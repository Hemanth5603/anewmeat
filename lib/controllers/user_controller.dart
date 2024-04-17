import 'dart:convert';
import 'dart:ffi';
import 'package:anewmeat/constants/api_constants.dart';
import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/models/otp_model.dart';
import 'package:anewmeat/models/user_model.dart';
import 'package:anewmeat/views/authentication/location.dart';
import 'package:anewmeat/views/authentication/otp.dart';
import 'package:anewmeat/views/authentication/signup.dart';
import 'package:anewmeat/views/authorized/tabs/home_page.dart';
import 'package:anewmeat/views/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserController extends GetxController{

  var userModelList = <UserModel>[].obs;
  UserModel userModel = UserModel();
  Rx<OtpModel> otpModel = OtpModel().obs; 
  TextEditingController nameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  var isLoading = false.obs;

  Future<void> getUser()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      isLoading(true);
      final uri = Uri.parse(APIConstants.baseUrl + APIConstants.getUser);

      final body = {
        "number":prefs.getString("phone")!
      };

      var response = await post(uri, body: body);
   
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        userModel = UserModel.fromJson(data);
      }else{
        if(kDebugMode) print("Error Fetching User Data");
      } 

      print("name - ${userModel.name}");
      print("email - ${userModel.email}");
      print("phone - ${userModel.number}");
    }catch (e) {
      if(kDebugMode) print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }

  }
  



  void sendOtp(bool checkUser) async {
    final uri = Uri.parse(APIConstants.baseUrl + APIConstants.otp);
    if(checkUser){
      if(!nameController.text.isNotEmpty){ 
      Fluttertoast.showToast(
        msg: "Name cannot be empty",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
      return;
    }
    if(!emailController.text.isNotEmpty){
      Fluttertoast.showToast(
        msg: "Email Cannot be empty",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
      return;
    }
    if(!validateEmail(emailController.text)){
      Fluttertoast.showToast(
        msg: "Invalid Email Address",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
      return;
    }
    }
    if(!validatePhoneNumber(phoneController.text)){
      Fluttertoast.showToast(
        msg: "Invalid Phone Number",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
      return;
    }
    Map<String,dynamic> body = {
      "number": phoneController.text,
    };
    isLoading(true);
    var response = await post(uri,body: body);
    
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      otpModel.value = OtpModel.fromJson(data);
      if(kDebugMode) print("OTP sent successfully------------------${otpModel.value.otp}" );
      isLoading(false);
      if(checkUser){
        if(otpModel.value.existingUser == "Y"){
          Fluttertoast.showToast(
            msg: "User Already Exists, Try Logining in...",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red
          );return;
        }
      }
      Get.to(const OTP(),transition: Transition.rightToLeft,duration: 300.milliseconds);
    }else{
      Fluttertoast.showToast(
        msg: "Failed to send OTP",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
    }

  }


  void resendOtp() async {
    final uri = Uri.parse(APIConstants.baseUrl + APIConstants.otp);
    if(!validatePhoneNumber(phoneController.text)){
      Fluttertoast.showToast(
        msg: "Invalid Phone Number",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
      return;
    }
    Map<String,dynamic> body = {
      "number": phoneController.text,
    };
    var response = await post(uri,body: body);
    if(response.statusCode == 200){
      var data = jsonDecode(response.body.toString());
      otpModel.value = OtpModel.fromJson(data);
      if(kDebugMode) print("OTP sent successfully------------------${otpModel.value.otp}" );
      
    }else{
      Fluttertoast.showToast(
        msg: "Failed to send OTP",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
    }
  }


  void verifyOtp() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(otpModel.value.otp.toString() == otpController.text){
      Get.to(const LocationScreen(),transition: Transition.rightToLeft,duration: 300.milliseconds);
      prefs.setInt("isLoggedIn",1);
      prefs.setString("name",nameController.text);
      prefs.setString("email",emailController.text);
      prefs.setString("phone",phoneController.text);
      registerUser();
    }else{
      Fluttertoast.showToast(
        msg: "Incorrect OTP",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red
      );
    }
  }

  void registerUser() async {
    final uri = Uri.parse(APIConstants.baseUrl + APIConstants.register);
    
    Map<String,dynamic> body = {
      "name":nameController.text,
      "number":phoneController.text,
      "email":emailController.text,
    };
    var response = await post(
      uri,
      body: body,
    );
    if(response.statusCode == 200){
      if(kDebugMode) print(response.body);
      if(kDebugMode) print("Regiestred usesr succesfully-----------------------------");
    }else{
      if(kDebugMode) print("Cannot register-----------------------------");
    }
  }

  Future<void> updateUser() async {
    isLoading(true);
    final uri = Uri.parse(APIConstants.baseUrl + APIConstants.register);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    Map<String,dynamic> body = {
      "name":nameController.text,
      "number":prefs.getString("phone"),
      "email":emailController.text,
    };
    var response = await post(
      uri,
      body: body,
    );
    if(response.statusCode == 200){
      if(kDebugMode) print(response.body);
      Fluttertoast.showToast(
        msg: "Updated User ",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Constants.customGreen
      );
      if(kDebugMode) print("Updated user succesfully-----------------------------");
    }else{
      if(kDebugMode) print("Cannot Update user-----------------------------");
    }
    isLoading(false);
  }


  Future<void> saveAddress(String address)async{
    final uri = Uri.parse(APIConstants.baseUrl + APIConstants.saveAddress);
    isLoading(true);
    Map<String,dynamic> body = {
      "number":phoneController.text,
      "address":address,
    };
    var response = await post(
      uri,
      body: body,
    );
    if(response.statusCode == 200){
      if(kDebugMode) print(response.body);
      if(kDebugMode) print("Address Saved Succesfully-----------------------------");
    }else{
      if(kDebugMode) print("Cannot Save Address-----------------------------");
    }
    isLoading(false);
  }

  void checkAppisAvailable(String address){
    List<String> availableCities = ['Visakhapatnam'];

    !address.contains(availableCities[0]) ?  print("App is not available") : Get.to(const Home(),transition: Transition.rightToLeft,duration:const Duration(milliseconds: 400));  
    
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

      userModel.latitude = position.latitude;
      userModel.longitude = position.longitude;
      userModel.address ="${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
      // =  "${place.street},${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}".obs();
    } catch (e) {
      print(e);
    }
  }






    bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length != 10) {
      return false;
    }
    for (int i = 3; i < phoneNumber.length; i++) {
      if (!phoneNumber[i].contains(RegExp(r'[0-9]'))) {
        return false;
      }
    }
    return true;
  }

  void logOut() async{
    SharedPreferences prefs = await  SharedPreferences.getInstance();
      prefs.setInt("isLoggedIn", 0);
      print(prefs.getInt("isLoggedIn"));
      Get.offAll(const SignUp());
  }






  bool validateEmail(String email) {
  if (email.isEmpty) {
    // Email should not be empty
    return false;
  }

  // Splitting the email address to get username and domain parts
  List<String> parts = email.split("@");
  if (parts.length != 2) {
    // Email should contain only one '@' symbol
    return false;
  }

  String username = parts[0];
  String domain = parts[1];

  if (username.isEmpty || domain.isEmpty) {
    // Username and domain parts should not be empty
    return false;
  }

  // Checking if domain contains at least one '.' after '@'
  if (!domain.contains(".") || domain.indexOf(".") <= 0) {
    return false;
  }

  // Checking if there are no consecutive dots in domain
  if (domain.contains("..")) {
    return false;
  }

  // Checking if domain ends with a valid top-level domain (TLD)
  List<String> domainParts = domain.split(".");
  String tld = domainParts.last;
  if (tld.length < 2 || tld.length > 6) {
    // TLD should have length between 2 and 6 characters
    return false;
  }

  // Assuming username can contain only alphanumeric characters, '.', '_', '-'
  RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9._-]+$');
  if (!usernameRegex.hasMatch(username)) {
    return false;
  }

  return true;
}

}



