import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  SearchCard({
    super.key,
    required this.h,
    required this.w,
    required this.id,
    required this.index,
    required this.productName,
    required this.imageUrl,
    required this.pieces,
    required this.originalPrice,
    required this.finalPrice,
    required this.isAdded,
    required this.quantity,
    this.value,
    required this.cartController,
  });
  double w;
  double h;
  String id;
  int index;
  String imageUrl;
  String productName;
  String pieces;
  String quantity;
  String originalPrice;
  String finalPrice;
  bool? isAdded;
  int? value = 1;
  CartController cartController;

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin:const EdgeInsets.symmetric(vertical: 5),
        width: widget.w,
        height: widget.w * 0.23,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: widget.w * 0.2,
                  height: widget.w * 0.2,
                  margin:const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.w * 0.72,
                      height: widget.h * 0.03,
                      child: Text(widget.productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 15),),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: widget.w * 0.73,
                      height: widget.h * 0.038,
                      child: Row(
                        children: [
                          Text("Pcs ${widget.pieces}  | ",style:const TextStyle(fontFamily: 'poppins',color: Colors.grey),),
                          Text("₹${widget.finalPrice}",style:const TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold),),
                          SizedBox(width: widget.w * 0.18,),
                          GestureDetector(
                            child: Container(
                              width: widget.w * 0.3,
                              height: widget.h * 0.038,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: widget.isAdded == true ? Border.all(color: Constants.customRed,width: 1) : Border.all(color: Constants.customGreen,width: 1),
                              ),
                              child: Center(
                                child: widget.isAdded == true
                                ? Text("Remove",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,color: Constants.customRed),)
                                : Text("Add to cart",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,color: Constants.customGreen),)
                              ),
                            ),
                            onTap: () async{
                              setState(() {
                                if(widget.isAdded == true){
                                  widget.cartController.deleteCartItem(widget.id);
                                  widget.isAdded = false;
                                }else{
                                  widget.cartController.addToCart(widget.id,widget.productName,widget.imageUrl, widget.originalPrice, widget.finalPrice, widget.quantity,widget.value);
                                  widget.isAdded = true;
                                } 
                                }
                              );
                            },
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 8,),
            Container(
              width: widget.w,
              height: 1,
              color: const Color.fromARGB(64, 158, 158, 158),
            ),
            
          ],
        ),
      ),
    );
  }
}