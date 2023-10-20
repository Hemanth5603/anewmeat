
import 'package:flutter/material.dart';

Widget categoryItem(w,h,imageURL,categoryName){
  return GestureDetector(
    child: Container(
      width: w * 0.2,
      height: h * 0.1,
      margin:const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width: w * 0.16,
            height: w * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(imageURL),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(height: 5,),
          Text(categoryName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,),)
        ],
      ),
    ),
  );
}
