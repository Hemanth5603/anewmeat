import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';

Widget addButton(w,h){
  return Container(
    width: w * 0.2,
    height: h * 0.039,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color:const Color.fromARGB(255, 211, 211, 211))
    ),
    child: Center(child: Text("ADD",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold,color: Constants.customRed,),)),
  );
}


