import 'package:anewmeat/views/authentication/otp.dart';
import 'package:anewmeat/views/home.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{


  void sendOtp(){
    Get.to(OTP(),transition: Transition.rightToLeft,duration: 300.milliseconds);
    print("call back");
  }

  void verifyOtp(){
    Get.to(Home());
  }
}