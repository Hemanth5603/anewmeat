import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';

Widget addButton2(w,h,isAdded){
  return Container(
    width: h * 0.05,
    height: h * 0.05,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 219, 219, 219),
          blurRadius: 2
        )
      ]
      
    ),
    child: Center(child: isAdded == true 
     ? Icon(Icons.delete,color: Constants.customRed,size: 20,)
     : Icon(Icons.add,color: Constants.customRed,)
     ),
  );
}


Widget addButton1(w,h,isAdded,id,name,imageUrl,originalPrice,finalPrice,quantity,value){
  return Container(
    width: w * 0.2,
    height: h * 0.035,
    padding:const EdgeInsets.only(left: 8,right: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(255, 219, 219, 219),
          blurRadius: 5
        )
      ]
      
    ),
    child: Center(child: isAdded == true 
     ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Delete",style: TextStyle(fontFamily: 'poppins',fontSize: 10,fontWeight: FontWeight.bold,color: Constants.customRed,),),
          Icon(Icons.delete,color: Constants.customRed,size: 16,)
       ],
     )
     : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Add",style: TextStyle(fontFamily: 'poppins',fontSize: 13,fontWeight: FontWeight.bold,color: Constants.customRed,),),
          Icon(Icons.add,color: Constants.customRed,size: 18,)
       ],
     )
     ),
  );
}



