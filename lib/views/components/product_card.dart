
import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/views/components/add_button.dart';
import 'package:anewmeat/views/components/free_delivery.dart';
import 'package:flutter/material.dart';

Widget productCard(w,h,imageURL,productName,productDescription,quantity,originalPrice,finalPrice,offer,isOffer,isFreeDelivery,isAdded){
  return Container(
    width: w * 0.5,
    margin:const EdgeInsets.only(left: 10,right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Stack(
      children: [
        Positioned(
          child: Container(
            width: w,
            height: h * 0.15,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(imageURL),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
        Positioned(
          top: h * 0.15,
          child:Container(
            width: w * 0.5,
            height: h * 0.15,
            padding:const EdgeInsets.all(10),
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(color: Color.fromARGB(255, 225, 225, 225),blurRadius: 10)
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(productDescription,style:const TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(quantity,style:const TextStyle(fontFamily: 'poppins',fontSize: 12,color: Color.fromARGB(255, 68, 68, 68)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    Text("₹" + originalPrice,style:const TextStyle(decoration: TextDecoration.lineThrough,fontFamily: 'poppins',fontSize: 14),),
                    const SizedBox(width: 5,),
                    Text("₹" + finalPrice,style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Constants.customRed,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 12,),
                    addButton(w, h,isAdded)
                  ],
                )
              ],
            ), 
          )
        ),
        Positioned(
          top: 15,
          child: Container(
            width: w * 0.15,
            height: w * 0.06,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
              color: Constants.customRed,
            ),
            child: Center(
              child: Text(offer + "% OFF",style:const TextStyle(fontFamily: 'poppins',fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ),
        ),
        if(isFreeDelivery) Positioned(
          top: w * 0.3,
          left: w * 0.2,
          child: freeDelivery(w, h)
        )
      ],
    ),
  );
}