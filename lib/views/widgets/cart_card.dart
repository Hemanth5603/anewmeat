import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/category_controller.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:anewmeat/views/components/category_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

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
    required this.quantity,
    required this.cartController,
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
  String quantity;
  CartController cartController;
  bool isLoading;

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
    width: widget.w,
    height: widget.h * 0.1,
    margin:const EdgeInsets.symmetric(vertical: 5),
    
    child: Row(
      children: [
        Container(
          width: widget.w * 0.21,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
                    child: Text(widget.productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  Row(
                    children: [
                      Text("₹${cartController.getCartModel!.products[0].items[widget.index].originalPrice.toString()}",style:const TextStyle(decoration: TextDecoration.lineThrough,fontFamily: 'poppins',fontSize: 12,color: Colors.grey),),
                      const Gap(5),
                      Text("₹${cartController.getCartModel!.products[0].items[widget.index].finalPrice.toString()}",style:const TextStyle(fontFamily: 'poppins',fontSize: 14,color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.quantity,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,color: Colors.grey),),
                  SizedBox(
                    width: widget.w * 0.22,
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: widget.w * 0.07,
                            height: widget.w * 0.07,
                            decoration: BoxDecoration(
                              color: Constants.customRed,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child:const Icon(Icons.add,color: Colors.white,size: 20,),
                          ),
                          onTap: (){
                            setState(() {
                              widget.isLoading = true;
                              cartController.incrementCartItemValue(widget.id,widget.index,widget.originalPrice,widget.finalPrice);
                              cartController.totalAmount = cartController.calculateTotalAmount();
                              if(kDebugMode) print(cartController.getCartModel!.products[0].items[widget.index].value!);
                              widget.isLoading = false;
                            });
                          },
                        ),
                        SizedBox(
                          width: widget.w * 0.08,
                          child: Center(child: Text(cartController.getCartModel!.products[0].items[widget.index].value.toString(),style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),)),
                        ),
                        GestureDetector(
                          child: Container(
                            width: widget.w * 0.07,
                            height: widget.w * 0.07,
                            decoration: BoxDecoration(
                              color: Constants.customRed,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child:const Icon(Icons.remove,color: Colors.white,size: 20,),
                          ) ,
                          onTap: (){
                            setState(() {
                              if(cartController.getCartModel!.products[0].items[widget.index].value! > 1){
                                widget.isLoading = true;
                                cartController.decrementCartItemValue(widget.id,widget.index,widget.originalPrice,widget.finalPrice);
                                cartController.totalAmount = cartController.calculateTotalAmount();
                                widget.isLoading = false;
                              }else{
                                showDialog(context: context, 
                                  builder: (context){
                                    return AlertDialog.adaptive(
                                  title: const Text("Want to delete item ?"),
                                  actions: [
                                    CupertinoDialogAction(
                                      onPressed: (){
                                        Get.back();
                                      },
                                      child:const Text("Back"),
                                    ),
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        Get.back();
                                        setState(()async{
                                          await cartController.deleteCartItem(widget.id);
                                          await cartController.getCartItems();
                                          cartController.cartItemsLength = cartController.getCartLength();
                                          cartController.totalAmount -= int.parse(widget.finalPrice);
                                          cartController.totalAmount = cartController.calculateTotalAmount();
                                          
                                        });
                                      },
                                      child: const Text("Delete"),
                                    )
                                  ],
                                  );
                                  }
                                );
                              }
                              if(kDebugMode) print(cartController.getCartModel!.products[0].items[widget.index].value!);
                            });
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