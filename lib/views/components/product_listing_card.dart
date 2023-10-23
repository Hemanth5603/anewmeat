
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
        Stack(
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
            Positioned(
              bottom: 8,
              left:30,
              child: addButton(w, h),
            )
          ],
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
            SizedBox(width:w * 0.56,height: h * 0.04, child: Text(productDescription,style:const TextStyle(fontSize: 12,color: Colors.grey,fontFamily: 'poppins'),maxLines: 2,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(offer + "% OFF",style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),),

                freeDelivery(w, h)
              ],
            ),
            SizedBox(height: h * 0.03,),
            Row(
              children: [
                Text("₹$originalPrice",style:const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 14,color: Colors.grey,),),
                const SizedBox(width: 10,),
                Text("₹$finalPrice",style: TextStyle(fontSize: 18,color: Constants.customRed,fontWeight: FontWeight.bold,fontFamily: 'poppins'),),
                SizedBox(width: w*0.12,),
                
              ],
            )
          ],
        ),
      ],
    )
  );
}




