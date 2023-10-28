import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    PageController pageController = PageController();
    return Scaffold(
      body:SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w,
                height: h * 0.06,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)
                    )
                  ],
                ),
              ),
              const SizedBox(height:5,),
              Container(
                width: w,
                height: h * 0.3,
                padding:const EdgeInsets.all(15),
                child: PageView(
                  children: [
                    Container(
                      width: w,
                      height: h * 0.1,
                      decoration:const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: NetworkImage("https://assets.tendercuts.in/product/C/H/a6b6b1db-2b6b-4129-a557-fbd9811c8888.webp"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.02,),
              Container(
                padding:const EdgeInsets.symmetric(horizontal:10), 
                child:const Text("(Medium Sized)",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),)
              ),
              Container(
                width: w,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: w * 0.5,
                      child:const Text("Chicken Curry Cut",style: TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold),),
                    ),

                    Container(
                      width: w * 0.22,
                      child: Row(
                        children: [
                          GestureDetector(
                            child: Container(
                              width: w * 0.07,
                              height: w * 0.07,
                              decoration: BoxDecoration(
                                color: Constants.customRed,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child:const Icon(Icons.add,color: Colors.white,),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.08,
                            child:const Center(child: Text("1",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),)),
                          ),
                          GestureDetector(
                            child: Container(
                              width: w * 0.07,
                              height: w * 0.07,
                              decoration: BoxDecoration(
                                color: Constants.customRed,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child:const Icon(Icons.remove,color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        )
      )
    );
  }
}