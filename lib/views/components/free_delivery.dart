import 'package:flutter/material.dart';

Widget freeDelivery(w,h){
  return Container(
    width: w * 0.25,
    height: h * 0.03,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 221, 221, 221)),
      color:const Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(15)
    ),
    child: Center(
      child: Text("FREE DELIVERY",style: TextStyle(color: Colors.black,fontFamily: 'poppins',fontSize: 10,fontWeight: FontWeight.bold),),
    ),
  );
}



