import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/billing_controller.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/category_controller.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:anewmeat/views/authorized/tabs/account/orders/orders_page.dart';
import 'package:anewmeat/views/components/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CartCard extends StatefulWidget {
  CartCard({super.key,
    required this.index,
    required this.id,
    required this.w,
    required this.h,
    required this.productName,
    required this.productImage,
    required this.originalPrice,
    required this.finalPrice,
    required this.oPrice,
    required this.fPrice,
    required this.quantity,
    required this.cartController,
    required this.billingController,
    required this.isLoading
  });
  int index;
  String id;
  double w;
  double h;
  String productName;
  String productImage;
  String originalPrice;
  String finalPrice;
  String oPrice;
  String fPrice;
  String quantity;
  CartController cartController;
  BillingController billingController;
  bool isLoading;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {


  Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue 
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 70,
            width: 50,
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Delete Selected Item ?",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(height: 25,),
              ],
            ),
          ),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
               //return false when click on "NO"
              child:const Text('No'),
            ),

            ElevatedButton(
              onPressed: ()async{
                Get.back();
                await cartController.deleteCartItem(widget.id); 
                await cartController.getCartItems();
                await billingController.checkCoupon("");
                setState((){
                  if(mounted){
                    //cartController.cartItemsLength = cartController.getCartLength();
                    widget.billingController.totalAmount -= int.parse(widget.finalPrice);
                  }
                });
              },
              //return true when click on "Yes"
              child:const Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }


  @override
  Widget build(BuildContext context) {
    return Container(
    width: widget.w,
    height: widget.h * 0.07,
    margin:const EdgeInsets.symmetric(vertical: 5),
    
    child: Row(
      children: [
        Container(
          width: widget.w * 0.16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:DecorationImage(
              image: NetworkImage(widget.productImage),
              fit: BoxFit.cover
            )
          ),
        ),
        const SizedBox(width: 10,),
        SizedBox(
          width: widget.w * 0.7,
          height: widget.h * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: widget.w * 0.46,
                    height: widget.h *0.035,
                    child: Text(widget.productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 12,fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      Text("₹${cartController.getCartModel!.products[0].items[widget.index].originalPrice.toString()}",style:const TextStyle(decoration: TextDecoration.lineThrough,fontFamily: 'poppins',fontSize: 12,color: Colors.grey),),
                      const SizedBox(height:5),
                      Text("₹${cartController.getCartModel!.products[0].items[widget.index].finalPrice.toString()}",style:const TextStyle(fontFamily: 'poppins',fontSize: 14,color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.quantity,style:const TextStyle(fontFamily: 'poppins',fontSize: 12,color: Color.fromARGB(255, 155, 155, 155),fontWeight: FontWeight.bold),),
                  SizedBox(
                    width: widget.w * 0.2,
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: widget.w * 0.06,
                            height: widget.w * 0.06,
                            decoration: BoxDecoration(
                              color: Constants.customRed,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child:const Icon(Icons.add,color: Colors.white,size: 20,),
                          ),
                          onTap: ()async{
                            await cartController.incrementCartItemValue(widget.id,widget.index,widget.oPrice,widget.fPrice);
                            await billingController.checkCoupon("");
                            if(kDebugMode) print(cartController.getCartModel!.products[0].items[widget.index].value!);
                          },
                        ),
                        SizedBox(
                          width: widget.w * 0.08,
                          child: Center(child: Text(cartController.getCartModel!.products[0].items[widget.index].value.toString(),style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),)),
                        ),
                        GestureDetector(
                          child: Container(
                            width: widget.w * 0.06,
                            height: widget.w * 0.06,
                            decoration: BoxDecoration(
                              color: Constants.customRed,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child:const Icon(Icons.remove,color: Colors.white,size: 20,),
                          ) ,
                          onTap: () async{
                              if(cartController.getCartModel!.products[0].items[widget.index].value! > 1){
                                await cartController.decrementCartItemValue(widget.id,widget.index,widget.oPrice,widget.fPrice);
                                await billingController.checkCoupon("");
                              }
                              else{
                                showExitPopup();
                              }
                              if(kDebugMode) print(cartController.getCartModel!.products[0].items[widget.index].value!);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
  }
}