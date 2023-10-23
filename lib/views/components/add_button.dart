import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';

Widget addButton(w,h){
  return Container(
    width: w * 0.2,
    height: h * 0.035,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      
    ),
    child: Center(child: Text("ADD",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold,color: Constants.customRed,),)),
  );
}


