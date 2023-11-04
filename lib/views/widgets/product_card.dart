import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/models/cart_model.dart';
import 'package:anewmeat/views/authorized/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    super.key,
    required this.w,
    required this.h,
    required this.imageURL,
    required this.productName,
    required this.productDesc,
    required this.pieces,
    required this.servings,
    required this.originalPrice,
    required this.finalPrice,
    required this.quantity,
    required this.value,
    required this.cartController
  });

  double w;
  double h;
  String? imageURL;
  String? productName;
  String? productDesc;
  String? pieces;
  String? servings;
  String? originalPrice;
  String? finalPrice;
  int? value;
  String? quantity;
  CartController cartController;




  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(bottom: widget.h * 0.02),
      width: widget.w,
      height: widget.h * 0.35,
  
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow:const [
                BoxShadow(
                  color: Color.fromARGB(255, 190, 190, 190),
                  blurRadius: 5
                )
              ],
      ),
      child: Column(
        children: [
          Container(
            width: widget.w,
            height: widget.h * 0.17,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(widget.imageURL!),
                fit: BoxFit.cover,
              )
            ),
          ),
          Container(
            width: widget.w,
            height: widget.h * 0.18,
            padding:const EdgeInsets.only(left: 10,right: 10),
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: widget.h * 0.02,),
                Text(widget.productName!,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                Text(widget.productDesc!,style:const TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),),
                const SizedBox(height: 5,),
                Text("500g | ${widget.pieces!}pieces | Serves ${widget.servings!}",style:const TextStyle(fontFamily: 'poppins',fontSize: 12,color:  Color.fromARGB(255, 118, 118, 118)),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text("₹${widget.originalPrice}", style:const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 14,fontFamily: 'poppins',color: Colors.grey),),
                    const SizedBox(width: 5,),
                    Text("₹${widget.finalPrice}",style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10,),
                    const Text("20% Off",style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: Colors.green),)
                  ],
                ),
                Row(
  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("today 6 AM - 8 AM",style: TextStyle(fontFamily: 'poppins',fontSize: 14,color: Colors.grey),),
                     GestureDetector(
                       child: Container(
                        width: widget.w * 0.24,
                        height: widget.h * 0.04,
                        padding:const EdgeInsets.only(left: 5,right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:const Color.fromARGB(255, 206, 53, 65)
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            !widget.cartController.cartList.contains(widget.productName) 
                            ? const Text("Add",style: TextStyle(fontFamily: 'poppins',color: Colors.white,fontSize: 15),) 
                            : const Text("Remove",style: TextStyle(fontFamily: 'poppins',color: Colors.white,fontSize: 15),)
                          ],
                        ),
                      ),
                      onTap: () async{
                        setState(() {
                          print("clicked");
                          if(widget.cartController.cartList.contains(widget.productName)){
                            widget.cartController.cartList.remove(widget.productName);
                          }else{
                            widget.cartController.cartList.add(widget.productName!);
                            //await widget.cartController.addToCart(widget.productName,widget.imageURL, widget.originalPrice, widget.finalPrice, widget.quantity,widget.value);
                          }
                        });
                        print(widget.cartController.cartList);
                      },
                    ) 
                  ],
                )
              ],
            ),
          )
        ],
      ),
    ),
    onTap: (){
      Get.to(ProductPage(
        imageURL:widget.imageURL!,
        productName: widget.productName!,
        productDesc:widget.productDesc!,
        price:widget.finalPrice!,
      ),transition: Transition.rightToLeft,duration:const Duration(milliseconds: 300));
    },
  );
  }
}