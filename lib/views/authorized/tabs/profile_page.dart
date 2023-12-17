import 'package:flutter/material.dart';

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
      backgroundColor: Color.fromARGB(255, 237, 237, 237),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical :10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  height: h * 0.13,
                  color: Colors.white,
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage("https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hemanth Srinivas",style: TextStyle(fontSize: 20,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text("7997435603 | shemanth.kgp@gmail.com",style: TextStyle(fontSize: 12,fontFamily: 'poppins',),)
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Tile(w,h,Icons.shopping_bag_outlined,"Orders"),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    width: w,
                    height: 1,
                    color: Color.fromARGB(255, 210, 210, 210),
                  ),
                ),
                Tile(w,h,Icons.location_on_outlined,"Addresses"),
              ],
            ),
          ), 
        ),
      )
    );
  }
}

Widget Tile(w,h,micon,title){
  return Container(
    width: w,
    height: h * 0.07,
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 15),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(micon, size: 20,),
            const SizedBox(width: 20,),
            Text(title,style: const TextStyle(fontFamily: 'poppins',fontSize: 18,),),
          ],
        ),
        const Icon(Icons.arrow_forward_ios_rounded,size: 20,)
      ],
    ),

  );
}