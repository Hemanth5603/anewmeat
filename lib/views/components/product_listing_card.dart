
import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/views/components/add_button.dart';
import 'package:anewmeat/views/components/free_delivery.dart';
import 'package:flutter/material.dart';

Widget productListingItem(w,h,imageURL,productName,productDescription,quantity,originalPrice,finalPrice,offer,isOffer,isFreeDelivery){
  return Container(
    margin:const EdgeInsets.all(10),
    width: w,
    height: h * 0.17,
    child: Row(
      children: [
        Container(
          width: w * 0.35,
          height: h * 0.17,
          decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(imageURL),
              fit: BoxFit.cover
            )
          ),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
            Container(width:w * 0.56, child: Text(productDescription,style:const TextStyle(fontSize: 12,color: Colors.grey,fontFamily: 'poppins'),maxLines: 2,)),
            Row(
              children: [
                Text(offer + "% OFF",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),),
                SizedBox(width: 10,),
                freeDelivery(w, h)
              ],
            ),
            SizedBox(height: h * 0.03,),
            Row(
              children: [
                Text("₹"+originalPrice,style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 14,color: Colors.grey,),),
                SizedBox(width: 10,),
                Text("₹"+finalPrice,style: TextStyle(decoration: TextDecoration.lineThrough,fontSize: 18,color: Constants.customRed,fontWeight: FontWeight.bold,fontFamily: 'poppins'),),
                SizedBox(width: w*0.12,),
                GestureDetector(
                  child: addButton(w, h)
                )
              ],
            )
          ],
        ),
      ],
    )
  );
}




