
import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/views/components/add_button.dart';
import 'package:anewmeat/views/components/free_delivery.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    super.key,
    required this.id,
    required this.value,
    required this.w,
    required this.h,
    required this.imageURL,
    required this.productName,
    required this.productDescription,
    required this.quantity,
    required this.originalPrice,
    required this.finalPrice,
    required this.offer,
    required this.isOffer,
    required this.isFreeDelivery,
    required this.isAdded,
    required this.controller
  });
  double w;
  double h;
  String id;
  int value;
  String imageURL;
  String productName;
  String productDescription;
  String quantity;
  String originalPrice;
  String finalPrice;
  String offer;
  bool? isOffer;
  String isFreeDelivery;
  bool? isAdded;
  CartController controller;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
    width: widget.w * 0.5,
    margin:const EdgeInsets.only(left: 10,right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Stack(
      children: [
        Positioned(
          child: Container(
            width: widget.w,
            height: widget.h * 0.15,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(widget.imageURL),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
        Positioned(
          top: widget.h * 0.15,
          child:Container(
            width: widget.w * 0.5,
            height: widget.h * 0.15,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Text(widget.productDescription,style:const TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    Text(widget.quantity,style:const TextStyle(fontFamily: 'poppins',fontSize: 12,color: Color.fromARGB(255, 68, 68, 68)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ],
                ),
                
                Row(
                  children: [
                    Text("₹${widget.originalPrice}",style:const TextStyle(decoration: TextDecoration.lineThrough,fontFamily: 'poppins',fontSize: 14),),
                    const SizedBox(width: 5,),
                    Text("₹${widget.finalPrice}",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Constants.customRed,fontWeight: FontWeight.bold),),
                    const SizedBox(width: 12,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(widget.isAdded == true){
                            widget.controller.deleteCartItem(widget.id);
                            widget.isAdded = false;
                          }else{
                            widget.controller.addToCart(widget.id,widget.productName,widget.imageURL, widget.originalPrice, widget.finalPrice, widget.quantity,widget.value);
                            widget.isAdded = true;
                          }
                        });
                        
                      },
                      child: Container(
                        width: widget.w * 0.2,
                        height: widget.h * 0.035,
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
                        child: Center(child: widget.isAdded == true 
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delete",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Constants.customRed,),),
                                Icon(Icons.delete,color: Constants.customRed,size: 16,)
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Add",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color: Constants.customRed,),),
                                Icon(Icons.add,color: Constants.customRed,size: 18,)
                              ],
                            )
                          ),
                      ),
                    ),
                  ],
                )
              ],
            ), 
          )
        ),
        Positioned(
          top: 15,
          child: Container(
            width: widget.w * 0.15,
            height: widget.w * 0.06,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
              color: Constants.customRed,
            ),
            child: Center(
              child: Text(widget.offer + "% OFF",style:const TextStyle(fontFamily: 'poppins',fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white),),
            ),
          ),
        ),
        if(widget.isFreeDelivery == "Y") Positioned(
          top: widget.w * 0.3,
          left: widget.w * 0.2,
          child: freeDelivery(widget.w, widget.h)
        )
      ],
    ),
  );
  }
}

