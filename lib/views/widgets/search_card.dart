import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatefulWidget {
  SearchCard({
    super.key,
    required this.h,
    required this.w,
    required this.index,
    required this.name,
    required this.imageUrl,
    required this.pieces,
    required this.price,
    required this.isAdded,
    required this.cartController,
  });
  double w;
  double h;
  int index;
  String imageUrl;
  String name;
  String pieces;
  String price;
  bool? isAdded;
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
                      child: Text(widget.name,style:const TextStyle(fontFamily: 'poppins',fontSize: 15),),
                    ),
                    const SizedBox(height: 20,),
                    SizedBox(
                      width: widget.w * 0.73,
                      height: widget.h * 0.038,
                      child: Row(
                        children: [
                          Text("Pcs ${widget.pieces}  | ",style:const TextStyle(fontFamily: 'poppins',color: Colors.grey),),
                          Text("₹${widget.price}",style:const TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold),),
                          SizedBox(width: widget.w * 0.18,),
                          Container(
                            width: widget.w * 0.3,
                            height: widget.h * 0.038,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Constants.customRed,width: 1),
                            ),
                            child: Center(
                              child: widget.isAdded == true
                              ? Text("Remove",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,color: Constants.customRed),)
                              : Text("Add to cart",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,color: Constants.customRed),)
                            ),
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