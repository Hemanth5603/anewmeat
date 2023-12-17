import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';

Widget addButton(w,h,isAdded){
  return Container(
    width: w * 0.2,
    height: h * 0.035,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(255, 219, 219, 219),
          blurRadius: 5
        )
      ]
      
    ),
    child: Center(child: isAdded == true 
     ? Text("Remove",style: TextStyle(fontFamily: 'poppins',fontSize: 12,fontWeight: FontWeight.bold,color: Constants.customRed,),)
     : Text("Add",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold,color: Constants.customRed,),)
     ),
  );
}


