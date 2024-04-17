import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/user_controller.dart';
import 'package:anewmeat/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';



class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}




class _LocationScreenState extends State<LocationScreen> {


  UserController userController = Get.put(UserController());

  String address = "null";
  String autocompletePlace = "null";
  Prediction? initialValue;
  final TextEditingController controller = TextEditingController();
  

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: w,
            height: address == "null" ? h * 0.75 : h * 0.67,
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/location1.png"),
                fit: BoxFit.cover
              )
            ),
          ),
          address == "null" ?
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
              height: h * 0.25,
              width: w,
              decoration:const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    color: Color.fromARGB(157, 158, 158, 158)
                  )
                ],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      //Icon(Icons.pin_drop_rounded,color: Constants.customRed,),
                      //const SizedBox(width: 10,),
                      Text("What's your location ?",style: TextStyle(fontFamily: 'poppins',fontSize: 25,color: Color.fromARGB(255, 30, 30, 30),fontWeight: FontWeight.bold),),
                    ],
                  ),
                  const Text("We need your location access to deliver your order",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Color.fromARGB(255, 158, 158, 158),),),
                  const SizedBox(height: 25,),
                  GestureDetector(
                    child: Container(
                      height: h * 0.06,
                      decoration: BoxDecoration(
                        borderRadius:const BorderRadius.all(Radius.circular(10)),
                        color: Constants.customRed
                      ),
                      child: const Center(
                        child: Text("Pick Location",style: TextStyle(fontFamily: 'poppins',color: Colors.white,fontSize: 16),),
                      )
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MapLocationPicker(
                              apiKey: 'AIzaSyA12cj1hCvSAsX4SAQdrqSieirOQYsmQTU',
                              popOnNextButtonTaped: true,
                              minMaxZoomPreference: const MinMaxZoomPreference(0,20),
                              hideMoreOptions: true,
                              bottomCardIcon: Icon(Icons.navigate_next_rounded,size: 35,color: Constants.customRed,),
                              hideMapTypeButton: true,
                              currentLatLng: LatLng(userController.userModel.latitude ?? 17.396234,userController.userModel.longitude ?? 78.474655),
                              onNext: (GeocodingResult? result) {
                                if (result != null) {
                                  setState(() {
                                    address = result.formattedAddress ?? "";
                                    //final SharedPreferences prefs = await SharedPreferences.getInstance();
                                    //prefs.setString("address",result.formattedAddress.toString());
                                    
                                    userController.userModel.address = result.formattedAddress ?? "";
                                    
                                  });
                                }
                              },
                              onSuggestionSelected: (PlacesDetailsResponse? result) {
                                if (result != null) {
                                  setState(() {
                                    autocompletePlace =
                                      result.result.formattedAddress ?? "";
                                });
                              }
                            },
                          );
                        },
                      ),
                    );
                    },
                  )
                ],
              ),
            ),
          ) : 
          Container(
            width: w,
            height: h * 0.33,
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
            decoration:const BoxDecoration(
              boxShadow: [
                  BoxShadow(
                    blurRadius: 25,
                    color: Color.fromARGB(157, 158, 158, 158)
                  )
                ],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    //Icon(Icons.pin_drop_outlined,color: Constants.customRed,),
                    //const SizedBox(width: 10,),
                    Text("Your current location",style: TextStyle(fontFamily: 'poppins',fontSize: 20,color: Color.fromARGB(255, 31, 31, 31),fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: h * 0.05,
                  child: Text(address,style: const TextStyle(fontFamily: 'poppins',fontSize: 14,color: Color.fromARGB(255, 52, 52, 52),fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2,)
                ),
                const SizedBox(height: 20,),
                GestureDetector(
                  child: Container(
                    height: h * 0.06,
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.customRed,width: 1),
                      borderRadius:const BorderRadius.all(Radius.circular(10)),
                      color: const Color.fromARGB(255, 255, 255, 255)
                    ),
                    child: Center(
                      child: Text("Use Another Address",style: TextStyle(fontFamily: 'poppins',color: Constants.customRed ,fontSize: 16),),
                    )
                  ),
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MapLocationPicker(
                              apiKey: 'AIzaSyA12cj1hCvSAsX4SAQdrqSieirOQYsmQTU',
                              popOnNextButtonTaped: true,
                              hideMoreOptions: true,
                              bottomCardIcon: Icon(Icons.navigate_next_rounded,size: 35,color: Constants.customRed,),
                              hideMapTypeButton: true,
                              currentLatLng: const LatLng(29.146727, 76.464895),
                              onNext: (GeocodingResult? result) {
                                if (result != null) {
                                  setState(() {
                                    address = result.formattedAddress ?? "";
                                    userController.userModel.address = result.formattedAddress ?? "";
                                  });
                                }
                              },
                              onSuggestionSelected: (PlacesDetailsResponse? result) {
                                if (result != null) {
                                  setState(() {
                                    autocompletePlace =
                                      result.result.formattedAddress ?? "";
                                });
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5,),
                const Center(
                  child:Text("or",style: TextStyle(fontSize: 14),)
                ),
                const SizedBox(height: 5,),
                GestureDetector(
                  child: Container(
                    height: h * 0.06,
                    decoration: BoxDecoration(
                      borderRadius:const BorderRadius.all(Radius.circular(10)),
                      color: Constants.customRed
                    ),
                    child: Obx(() => !userController.isLoading.value ? const Center(
                      child: Text("Continue ",style: TextStyle(fontFamily: 'poppins',color: Colors.white ,fontSize: 16),),
                    ):const Center(child: CircularProgressIndicator(strokeWidth: 2,color: Colors.white,),) )
                  ),
                  onTap: () async{
                    await userController.saveAddress(address);
                    Get.to(const Home(),transition: Transition.rightToLeft,duration:const Duration(milliseconds: 400));
                    //userController.checkAppisAvailable(address);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}