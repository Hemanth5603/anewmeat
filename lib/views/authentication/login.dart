import 'package:anewmeat/controllers/auth_controller.dart';
import 'package:anewmeat/views/components/custom_button.dart';
import 'package:anewmeat/views/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

AuthController authController = Get.put(AuthController());

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * 0.45,
                width: w,
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.02,top: h * 0.1),
                  child: Image.asset("assets/icons/appicon.png",filterQuality: FilterQuality.high,)
                )
              ),
              SizedBox(height: h * 0.03,),
              const Padding(
                padding: EdgeInsets.only(left: 40),
                child: Text("Enter Mobile Number to Login",style:TextStyle(fontFamily: 'poppins',fontSize: 16),),
              ),
              CustomTextField(w:w,h: h * 0.07,maxLines: 1,keyboardType: TextInputType.number,hint:"Phone Number"),
              SizedBox(
                width: w,
                height : h * 0.15,
                child: CustomButton(title: "Send OTP",height: h * 0.08,width: w * 0.82,callback: authController.sendOtp,)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customTextField(w,h,maxLines,keyboardType,hint){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: w * 0.09, vertical: 12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow:const [
            ]
          ),
          child: TextField(
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 13, 8, 8),
              hintText: hint,
              enabledBorder: getBorder(),
              focusedBorder: getBorder(),
              focusColor: Colors.black,
              prefixStyle: const TextStyle(color: Colors.black),
              hintStyle:const TextStyle(fontFamily: 'poppins',fontSize: 16,color: Color.fromARGB(255, 76, 76, 76)),
              //prefixIcon: Icon(Icons.no,color: Color.fromARGB(200, 0, 44, 107)),
            ),
            maxLines: maxLines,
            keyboardType: keyboardType,
          ),
        ),
      ],
    ),
  );
}

OutlineInputBorder getBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(width: 1.5, color: Color.fromARGB(255, 204, 32, 46)),
      gapPadding: 2,
  );
}