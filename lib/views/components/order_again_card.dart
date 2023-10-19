


import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';

Widget orderAgainCard(w,h,orderName,totalPrice,orderDate,summary){
  return Container(
    margin:const EdgeInsets.all(10),
    padding:const EdgeInsets.all(10),
    width: w * 0.5,
    height: h * 0.2,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: const Color.fromARGB(255, 206, 206, 206))
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: w * 0.5,
          child: Text(orderName,style:const TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),)
        ),
        const SizedBox(height: 5,),
        Text("₹" + totalPrice,style: TextStyle(fontSize: 14,fontFamily: 'poppins',color: Constants.customRed,fontWeight: FontWeight.bold),),
        const SizedBox(height: 5,),
        Text("Last Ordered on "+orderDate,style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: Colors.grey)),
        const SizedBox(height: 15,),
        Text(summary,style: const TextStyle(fontFamily: 'poppins',fontSize: 12,color: const Color.fromARGB(255, 57, 57, 57),))
      ],
    ),
  );
}
