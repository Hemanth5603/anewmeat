import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var otpCode;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon:const Icon(Icons.arrow_back_ios_new_rounded,size: 30,color: Color.fromARGB(255, 204, 32, 46),weight: 1,),
                  onPressed: (){
                    Get.to(const Login(),transition: Transition.leftToRight,duration: 300.milliseconds);
                  },
                ),
              ),
              SizedBox(
                height: h * 0.35,
                width: w,
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.02,top: h * 0.1),
                  child: Image.asset("assets/icons/appicon.png",filterQuality: FilterQuality.high,)
                )
              ),
              SizedBox(height: h * 0.03,),
              Padding(
                padding: EdgeInsets.only(left: w * 0.1),
                child: const Text("Enter OTP send to your Mobile Number",style:TextStyle(fontFamily: 'poppins',fontSize: 16),),
              ),
              Container(
                width: w * 0.7,
                height: h * 0.065,
                margin: EdgeInsets.only(left: w * 0.15,top: 20),
                child: PinFieldAutoFill(
                  currentCode: otpCode,
                  decoration: BoxLooseDecoration(
                    textStyle: const TextStyle(fontFamily: 'poppins',color: Colors.black,fontSize: 20),
                  radius:const Radius.circular(8),
                  strokeColorBuilder:const FixedColorBuilder(
                    Color.fromARGB(255, 204, 32, 46))),
                    
                    codeLength: 4,
                    onCodeChanged: (code) {
                      otpCode = code;
                    },
                  onCodeSubmitted: (val) {
                    
                  }
                )
              ),
              Container(
                margin: EdgeInsets.only(left: w* 0.1,top: 0),
                child: Row(
                  children: [
                    const Text("Didn't recieve OTP ?",style: TextStyle(fontFamily: 'poppins',fontSize: 14),),
                    const SizedBox(width: 10,),
                    TextButton(onPressed: (){

                    },
                    child:const Text("Resend OTP",style: TextStyle(color:Color.fromARGB(255, 204, 32, 46),fontFamily: 'poppins',fontSize: 14),))
                  ],
                ) ,
              ),
              SizedBox(
                 width: w,
                height : h * 0.15,
                child: CustomButton(title: "Login", height: h*0.07, width: w * 0.8, callback: authController.verifyOtp)
              )
              


            ],
          ),
        ),
      ),
    );
  }
}