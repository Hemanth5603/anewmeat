import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/views/authorized/tabs/account/orders/orders_page.dart';
import 'package:anewmeat/views/authorized/tabs/account/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double h =MediaQuery.of(context).size.height;
    double w =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 251, 255),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical :0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  height: h * 0.12,
                  padding: EdgeInsets.all(8),
                  color: Colors.white,
                  child: Column(
                    children: [
                       Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  const Text("Hemanth Srinivas",style: TextStyle(fontSize: 20,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                                  SizedBox(width: w * 0.09,),
                                  TextButton(
                                    onPressed: (){
                                      Get.to(const EditProfile(),transition: Transition.rightToLeft,duration: const Duration(milliseconds: 400));
                                    }, 
                                    child: Text("Edit",style: TextStyle(fontFamily: 'poppins',color: Constants.customRed,fontWeight: FontWeight.bold),)
                                  ),
                                ],  
                              ),
                              const SizedBox(height: 0,),
                              const Text("7997435603 | shemanth.kgp@gmail.com",style: TextStyle(fontSize: 12,fontFamily: 'poppins',),)
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),

                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                GestureDetector(
                  child: Tile(w,h,Icons.shopping_bag_outlined,"Orders","Total Orders: 10",true,false),
                  onTap: (){
                    Get.to(()=> const OrdersPage());
                  },
                ),
                Tile(w,h,Icons.location_on_outlined,"Addresses","Saved Addresses: 2",true,false),
                Tile(w,h,Icons.call_outlined,"Contact us","",false,false),
                Tile(w,h,Icons.edit_document,"Terms & Conditions","",false,true),
                const SizedBox(height: 8,),
                Tile(w,h,Icons.logout_outlined,"Logout","",false,true),
              ],
            ),
          ), 
        ),
      )
    );
  }
}

Widget Tile(w,h,micon,title,subtitle,isExtraData,isLast){
  return Column(
    children: [
      Container(
        width: w,
        height: h * 0.08,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(micon, size: 20,color: Color.fromARGB(255, 163, 163, 163),),
                const SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,style: const TextStyle(fontFamily: 'poppins',fontSize: 16,color: Color.fromARGB(255, 52, 52, 52)),),
                    isExtraData ? Text(subtitle,style: const TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey)) : Container(),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios_rounded,size: 20,color: Constants.customRed,)
          ],
        ),
      ),
      !isLast ? Container(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          width: w,
          height: 1,
          color: Color.fromARGB(153, 210, 210, 210),
        ),
      ) : Container(),
    ],
  );
}