import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/user_controller.dart';
import 'package:anewmeat/views/components/custom_button.dart';
import 'package:anewmeat/views/components/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

UserController userController = Get.put(UserController());

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 255, 255, 255), // Change the color to your desired color
      statusBarIconBrightness: Brightness.dark, // Change the brightness of icons
    ));
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
              children: [
                Container(
                  width: w,
                  height: h * 0.4,
                  decoration:const BoxDecoration(
                    image: DecorationImage( 
                      image: AssetImage("assets/images/loginHero.jpg"),
                      fit: BoxFit.fitHeight,
                    )
                  )
                ),
                Container(
                  width: w,
                  height: h * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                       const Color.fromARGB(255, 0, 0, 0).withOpacity(0.0),
                       const Color.fromARGB(191, 26, 26, 26),
                      ],stops: const [
                        0.0,
                        1.0
                        ]
                      )
                    ),
                  ),
                  const Positioned(
                    bottom: 60,
                    left: 15,
                    child: Text("Hi there!",style: TextStyle(fontSize: 40,fontFamily: 'poppins',fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
                const Positioned(
                    bottom: 20,
                    left: 15,
                    child: Text("Welcome to Anewmeat",style: TextStyle(fontSize: 25,fontFamily: 'poppins',fontWeight: FontWeight.bold,color: Color.fromARGB(221, 255, 255, 255)),
                  ),
                )
              ],
            ),
              const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:const EdgeInsets.only(left:10.0),
                    child: Text("Login with Phone Number",style: TextStyle(fontFamily: 'poppins',fontSize: 25,fontWeight: FontWeight.bold,color: Constants.customRed)),
                  ),
                  const SizedBox(height: 16,),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 45,
                      width: w,
                      decoration:const BoxDecoration(
                        color: Color.fromARGB(255, 230, 230, 230),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 7,),
                          const Text("+91",style: TextStyle(fontSize: 16,fontFamily: 'poppins'),),
                          const SizedBox(width: 7,),
                          const VerticalDivider(width: 1,color: Color.fromARGB(255, 182, 182, 182),),
                          const SizedBox(width: 10,),
                          SizedBox(
                            height: h * 0.1,
                            width: w* 0.7,
                            child:  Center(
                              child: TextField(
                                controller: userController.phoneController,
                                keyboardType: TextInputType.phone,
                                textAlignVertical: TextAlignVertical.bottom,
                                style:const TextStyle(fontFamily: 'poppins'),
                                decoration:const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone number",
                                  hintStyle: TextStyle(color: Color.fromARGB(255, 106, 106, 106))
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: 50,
                        width: w * 0.89,
                        decoration:BoxDecoration(
                          border: Border.all(color:const Color.fromARGB(255, 244, 55, 55),width: 2),
                          color:Constants.customRed,
                          borderRadius:const BorderRadius.all(Radius.circular(10))
                        ),
                        child:Obx(()=> !userController.isLoading.value ? const Center(
                          child: Text("Send Otp",style: TextStyle(fontSize: 20,color: Colors.white),),
                        ): const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),)),
                      ),
                    ),
                    onTap: ()async{
                      userController.sendOtp(false);
                    }
                  ),
                  SizedBox(height: h * 0.22),
                  Container(
                    margin:const EdgeInsets.only(left: 80),
                    child:const Column(
                      children: [
                        Text("By Continuing you agree ",style: TextStyle(fontSize: 12,color: Colors.grey),),
                        SizedBox(height: 2,),
                        Text("Terms of Service   Privacy Policy ",style: TextStyle(fontSize: 12,color: Colors.grey))
                      ],
                    ),

                  )
                ],
              ),
            )
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