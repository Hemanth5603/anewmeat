import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/models/coupon_model.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CouponCard extends StatefulWidget {
  CouponCard({
    super.key,
    required this.w,
    required this.h,
    required this.name,
    required this.code,
    required this.conditions,
  });
  
  double w;
  double h;
  String name;
  String code;
  List<Conditions>? conditions;
  @override
  State<CouponCard> createState() => _CouponCardState();
}


class _CouponCardState extends State<CouponCard> {
  late double cHeight = widget.h * 0.165;
  bool isExtended = false;
  

  @override
  Widget build(BuildContext context) {
    
    return AnimatedContainer(
      duration:const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 15),
      padding:const EdgeInsets.symmetric(horizontal: 10),
      width: widget.w,
      height: cHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.local_offer_rounded,color: Constants.customGreen,),
              const SizedBox(width: 10,),
              Container(
                width: widget.w * 0.55,
                child: Text(widget.name,style: const TextStyle(fontSize: 14,fontFamily: 'poppins',fontWeight: FontWeight.bold),)),
              const SizedBox(width: 20,),
              TextButton(onPressed: (){
              },
              child:Text("Apply",style: TextStyle(fontFamily: 'poppins',fontSize: 14,color: Constants.customRed,fontWeight: FontWeight.bold),)
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color:const Color.fromARGB(255, 252, 236, 202),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: Text(widget.code,style:const TextStyle(fontFamily: 'poppins',fontSize: 12,fontWeight: FontWeight.bold),),
                ),
              ),
              Row(
                children: [
                  const Text("Terms and Conditions",style: TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey)),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if(isExtended){
                           cHeight = widget.h * 0.165;
                           isExtended = false;
                        }
                        else{
                          cHeight = widget.h * 0.3;
                          isExtended = true;
                        }
                      });
                  }, icon: const Icon(Icons.arrow_drop_down_rounded,size: 30,)),
                ],
              )
            ],
          ),
          Visibility(
            visible: isExtended,
            child:const Text("Terms & Conditions",style: TextStyle(fontSize: 14),),
          ),
          const SizedBox(height: 20,),
          Visibility(
            visible: isExtended,
            child: Container(
              height: widget.h * 0.1,
              child: ListView.builder(
                itemCount: widget.conditions?.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.only(left: 10,bottom: 10),
                    child: Text(" - " + widget.conditions![index].description,style:const TextStyle(fontFamily: 'poppins'),)
                  );
                }
              ),
            ),
          )

        ],
      ),
    );
  }
}