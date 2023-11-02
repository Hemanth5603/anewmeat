import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key,required this.imageURL, required this.productName,required this.productDesc,required this.price});
  final String imageURL;
  final String productName;
  final String productDesc;
  final String price;

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
      bottomNavigationBar: Container(
        padding:const EdgeInsets.symmetric(horizontal: 15),
        width: w,
        height: h * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Total Price",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                Text("₹"+widget.price,style: TextStyle(fontFamily: 'poppins',fontSize:20,color: Constants.customRed,fontWeight: FontWeight.bold),)
              ],
            ),
            GestureDetector(
              child: Container(
                width: w * 0.4,
                height: h * 0.06,
                padding:const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Constants.customRed,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add to Cart",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,color: Colors.white)),
                    Container(
                      width: w * 0.08,
                      height: w * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color.fromARGB(83, 255, 255, 255)),
                        color: const Color.fromARGB(55, 255, 255, 255)
                      ),
                      child:const Center(
                        child: Icon(Icons.shopping_cart_outlined,color: Colors.white,size: 18,),
                      ),
                    )
                  ],
                ), 
              ),
            )
          ],
        ),
      ),
      body:SafeArea(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w,
                height: h * 0.05,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: (){
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded)
                    )
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: w,
                    height: h * 0.3,
                    padding:const EdgeInsets.symmetric(horizontal: 15),
                    child: PageView(
                      children: [
                        Container(
                          width: w,
                          height: h * 0.1,
                          decoration:BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: NetworkImage(widget.imageURL),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 30,
                    child: Container(
                      width: w * 0.1,
                      height: w * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: IconButton(
                        onPressed: (){
                          
                        },
                        icon: Icon(Icons.favorite,color: Constants.customRed,),
                      ),
                    ),
                  )
                ],
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
                    SizedBox(
                      width: w * 0.5,
                      child:Text(widget.productName ?? widget.productName ,
                      style:const TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,maxLines: 2,),
                    ),

                    SizedBox(
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
                              child:const Icon(Icons.add,color: Colors.white,size: 20,),
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
                              child:const Icon(Icons.remove,color: Colors.white,size: 20,),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                width: w,
                height: h * 0.14,
                child:Text(widget.productDesc,
                  style: const TextStyle(fontFamily: 'poppins',fontSize: 12,color: Color.fromARGB(255, 156, 156, 156)),textAlign: TextAlign.justify,
                )
              ),
              Container(
                width: w,
                padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                child:const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Delivery Time:",style: TextStyle(fontFamily: 'poppins',fontSize: 16,),),
                    Text("Tomorrow 6AM - 8AM",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),)  // Assist for JSON
                  ],
                ),
              ),
              Container(
                width: w,
                padding:const EdgeInsets.all(12),
                child:const Text("Nutritional Information:    (Approx Values per 100 g)",style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold),),
              ),
              Container(
                width: w,
                height: h * 0.11,
                padding:const EdgeInsets.symmetric(horizontal: 12),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  childAspectRatio: 5,
                  mainAxisSpacing: 0,
                  shrinkWrap: false,
                  children: List.generate(4, (index) {
                    return const Text("Energy : 12cal",style: TextStyle(fontSize: 16,fontFamily: 'poppins',));
                  })
                ),
              ),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Note*",style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: Constants.customRed,fontWeight: FontWeight.bold),),
                    const Text("Anewmeat meats are chilled between 0-4°C to maintain freshness. Do not freeze.",style: TextStyle(fontFamily:"poppins",fontSize: 12,color: Color.fromARGB(255, 30, 30, 30) ),)
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