
import 'package:flutter/material.dart';

Widget allButton(w,h){
  return Container(
    width: w * 0.15,
    height: w * 0.1,
    padding: EdgeInsets.only(left: 5),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 201, 201, 201)),
      borderRadius: BorderRadius.circular(10)
    ),
    child:const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("ALL",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold),),
        SizedBox(width: 2,),
        Icon(Icons.chevron_right_rounded)
      ],
    ),
  );
}