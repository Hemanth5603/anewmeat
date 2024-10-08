
import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/views/components/add_button.dart';
import 'package:anewmeat/views/components/free_delivery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListingItem extends StatefulWidget {
  ProductListingItem({
    super.key,
    required this.w,
    required this.h,
    required this.id,
    required this.imageUrl,
    required this.productName,
    required this.productDesc,
    required this.quantity,
    required this.originalPrice,
    required this.finalPrice,
    required this.isFreeDelivery,
    required this.offer,
    required this.isOffer,
    required this.isAdded,
    required this.cartController,
    required this.pieces,
    required this.servings,
    this.value,
  });
  double w;
  double h;
  String id;
  String imageUrl;
  String productName;
  String productDesc;
  String quantity;
  String originalPrice;
  String finalPrice;
  String offer;
  late bool isOffer;
  String isFreeDelivery;
  String servings;
  String pieces;
  bool? isAdded;
  int? value = 1;
  CartController cartController;


  @override
  State<ProductListingItem> createState() => _ProductListingItemState();
}

class _ProductListingItemState extends State<ProductListingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
    margin:const EdgeInsets.all(10),
    
    height: widget.h * 0.2,
    child: Row(
      children: [
        Stack(
          children: [
            GestureDetector(
              child: Container(
                width: widget.w * 0.35,
                height: widget.h * 0.18,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover
                  )
                ),
              ),
            ),
            Container(
              width: widget.w * 0.35,
              height: widget.h * 0.18,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                gradient:  LinearGradient(
                  stops: [
                    0.5,
                    0.9
                  ],
                  colors: [
                    Color.fromARGB(0, 255, 255, 255),
                    Color.fromARGB(179, 0, 0, 0)
                  ],
                  
                  begin: Alignment.topLeft,
                  end:Alignment.bottomRight
                )
              ),
            ),
            Positioned(
              bottom: 8,
              right: 10,
              child: GestureDetector(
                child: addButton2(widget.w, widget.h,widget.isAdded),
                onTap: () async{
                  setState(() {
                    if(widget.isAdded == true){
                      widget.cartController.deleteCartItem(widget.id);
                      widget.isAdded = false;
                    }else{
                      widget.cartController.addToCart(widget.id,widget.productName,widget.imageUrl, widget.originalPrice, widget.finalPrice, widget.quantity,widget.value);
                      widget.isAdded = true;
                    }
                  });

                },
              ),
            ),
          ],
        ),
        const SizedBox(width: 10,),
        Padding(
          padding:const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                  Text("${widget.quantity} | ${widget.pieces} Pieces | Serves ${widget.servings} ",style: TextStyle(fontSize: 10,color: const Color.fromARGB(255, 58, 58, 58),fontFamily: 'poppins'),),
                  Container(
                    width:widget.w * 0.56,
                    height: widget.h * 0.06,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(widget.productDesc,style:const TextStyle(fontSize: 10,color: Colors.grey,fontFamily: 'poppins'),maxLines: 2,overflow: TextOverflow.ellipsis,)
                  ),
                ],
              ),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                  width: widget.w * 0.56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${widget.offer}% OFF",style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),),
                      freeDelivery(widget.w, widget.h)
                    ],
                  ),
                ),
                SizedBox(height: widget.h * 0.01,),
                Row(
                  children: [
                    Text("₹${widget.originalPrice}",style:const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 14,color: Colors.grey,),),
                    const SizedBox(width: 10,),
                    Text("₹${widget.finalPrice}",style: TextStyle(fontSize: 18,color: Constants.customRed,fontWeight: FontWeight.bold,fontFamily: 'poppins'),),
                    SizedBox(width: widget.w * 0.12,),
                  ],
                )
                ],
              )
            ],
          ),
        ),
      ],
    )
  );
  }
}

