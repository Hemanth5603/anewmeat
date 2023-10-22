import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/authentication/otp.dart';
import 'package:anewmeat/views/components/custom_button.dart';
import 'package:anewmeat/views/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // ignore: prefer_typing_uninitialized_variables
  var otpCode;
  bool checkBoxValue = false;
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
                    Get.to(const OTP(),transition: Transition.leftToRight,duration: 300.milliseconds);
                  },
                ),
              ),
              SizedBox(
                height: h * 0.3,
                width: w,
                //color: Colors.red,
                child: Padding(
                  padding: EdgeInsets.only(left: w * 0.02,top: h * 0),
                  child: Image.asset("assets/icons/appicon.png",filterQuality: FilterQuality.high,)
                )
              ),
              SizedBox(height: h * 0.03,),
              Padding(
                padding: EdgeInsets.only(left: w * 0.1),
                child: Text("Enter Details",style:TextStyle(fontFamily: 'poppins',fontSize: 18,color: Colors.grey.shade700),),
              ),
              CustomTextField(w:w,h: h * 0.07,maxLines: 1,keyboardType: TextInputType.name,hint:"Full Name"),
              CustomTextField(w:w,h: h * 0.07,maxLines: 1,keyboardType: TextInputType.emailAddress,hint:"Email"),
              SizedBox(height: h * 0.1,),
              Container(
               margin:const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.red,
                      value: checkBoxValue, 
                      onChanged: (value){
                        setState(() {
                          checkBoxValue = value!;
                        });
                      }
                    ),
                    const SizedBox(width: 0,),
                    const Text("I have read and agree to the terms and conditions",style: TextStyle(fontSize: 12,color: Colors.grey,fontFamily: 'poppins'),)
                  ],
                ),
              ),

              /*SizedBox(
                 width: w,
                height : h * 0.1,
                child: CustomButton(title: "Continue", height: h * 0.07, width: w * 0.8, callback: authController.register)
              )*/
              


            ],
          ),
        ),
      ),
    );
  }
}