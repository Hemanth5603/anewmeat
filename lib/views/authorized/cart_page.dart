import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartController.getCartItems();
    
  }
  @override
  Widget build(BuildContext context){
    CartController cartController = Get.put(CartController());
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),
          onPressed: (){

          },
        ),
        title: const Text("Cart",style: TextStyle(fontFamily:'poppins',fontSize: 22,color: Colors.black),),
      ),

      bottomNavigationBar: Container(
        width: w,
        height: h * 0.14,
        padding:const EdgeInsets.all(15),
        decoration:const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          boxShadow:[
            BoxShadow(
              color:Color.fromARGB(255, 181, 181, 181), 
              blurRadius: 10,
            ),
          ] 
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Icon(Icons.home_rounded),
                const SizedBox(width: 5,),
                SizedBox(
                  width: w * 0.75,
                  child: const Text("Home, 11-9-29A1,Daspalla Hills, Siripuram,visakhapatnam",style: TextStyle(fontFamily: 'poppins',fontSize: 12,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold),),
                ),
                const SizedBox(width: 10,),
                const Icon(Icons.chevron_right_rounded)
              ],
            ),
            const SizedBox(height: 10,),
            Container(
              width: w,
              height: h * 0.06,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Constants.customRed,
              ), 
              child:const Center(
                child: Text("Pay ₹709",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
                width: w,
                height: h + h/2,
                color:const Color.fromARGB(255, 237, 237, 237),
                child: Column(
                  children: [
                    Container(
                      width: w,
                      height: h * 0.03,
                      color: const Color.fromARGB(255, 255, 243, 209),
                      child: Row(
                        children: [
                          SizedBox(width: w * 0.03,),
                          const Text("You have saved ₹80!",style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: Colors.green,fontWeight: FontWeight.bold),),
                          
                        ],
                      ),
                    ),
                    Container(
                      width: w,
                      height: h * 0.35,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Review Items",style: TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(height: h * 0.02,),
                            SizedBox(
                              width: w,
                              height: h * 0.22,
                              child: Obx(() => cartController.isLoading.value
                              ? const CircularProgressIndicator()
                              : ListView.builder(
                                itemCount: cartController.getCartModel!.items?.length,
                                itemBuilder: (context,index){
                                  return cartItem(w, h);
                                }
                              ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.02,),
                    Container(
                      width: w,
                      padding:const EdgeInsets.all(12),
                      height: h * 0.25,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Offers & Benefits",style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: h * 0.02,),
                          Container(
                            width: w,
                            height: h * 0.06,
                            padding:const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green)
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.local_offer_rounded,color: Color.fromARGB(255, 77, 160, 125),),
                                const SizedBox(width: 10,),
                                const Text("Apply Coupon",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 77, 160, 125)),),
                                SizedBox(width: w * 0.4,),
                                const Icon(Icons.chevron_right_rounded,color: Color.fromARGB(255, 77, 160, 125),size: 30,)
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Row(
                            children: [
                              Container(
                                width: w * 0.7,
                                height: h * 0.06,
                                padding:const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color:const Color.fromARGB(255, 77, 160, 125))
                                ),
                                child: const TextField(
                                  style: TextStyle(fontFamily: 'poppins',fontSize: 18,color: Color.fromARGB(255, 77, 160, 125)),
                                  decoration: InputDecoration(
                                    hintText: "Enter Coupon code here",
                                    hintStyle: TextStyle(fontFamily: 'poppins',fontSize: 14,color:Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  textCapitalization: TextCapitalization.characters,
                                  cursorColor: Color.fromARGB(255, 77, 160, 125),   
                                ),
                              ),
                              const SizedBox(width: 10,),
                              GestureDetector(
                                child:Container(
                                  width: w* 0.2,
                                  height: h * 0.06,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(255, 77, 160, 125)
                                  ),
                                  child: const Center(
                                    child: Text("Add",style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                                  ),
                                )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.02,),
                    Container(
                      width: w,
                      height: h * 0.17,
                      color: Colors.white,
                      padding:const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Bill Summary",style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: h * 0.01,),
                          billItem("Item Total","₹709",Colors.black),
                          SizedBox(height: h * 0.01,),
                          billItem("Delivery fee","₹50",Colors.black),
                          SizedBox(height: h * 0.01,),
                          billItem("Total","₹759",Colors.black),
                        ],
                      ),
                    ),
                    SizedBox(height: h * 0.008,),
                    Container(
                      width: w,
                      color: Colors.white,
                      height: h * 0.1,
                      padding:const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          billItem("ANEWMEAT50", "-₹50", Colors.blue),
                          const SizedBox(height:10,),
                          billItem("Net Payable", "₹709", Colors.black)
                        ],
                      ),
                    ),  
                    const SizedBox(height: 15,),
                    const Text("CANCELLATION POLICY",style: TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.bold,color: Colors.grey),),
                    const SizedBox(height: 10,),
                    Container(
                      width: w,
                      color: Colors.white,
                      height: h * 0.12,
                      padding:const EdgeInsets.all(12),
                      child:const Column(
                        children: [
                          Text("100% Cancellation fee will be applicable only if you decide to cancel the order before it is dispatched.",
                            style: TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),  
                          ),
                          SizedBox(height:10,),
                          Text("You can reschedule your delivery to a later time only until items are dispatched",
                            style: TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),  
                          ),
                        ],
                      ),
                    ),  
                  ],
                ),
              ),
            ),
      )
    );
  }
}



Widget billItem(title,amount,color){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,color: color)),
      Text(amount,style: TextStyle(fontFamily: 'poppins',fontSize: 14,fontWeight: FontWeight.bold,color: color),)
    ],
  );
}



Widget cartItem(w,h){
  return Container(
    width: w,
    height: h * 0.1,
    margin:const EdgeInsets.symmetric(vertical: 5),
    
    child: Row(
      children: [
        Container(
          width: w * 0.21,
          height: w * 0.21,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image:const DecorationImage(
              image: NetworkImage("https://assets.tendercuts.in/category/C/h/444c122b-a639-48ff-8078-5b9b5af74596.jpg")
            )
          ),
        ),
        const SizedBox(width: 10,),
        SizedBox(
          width: w * 0.7,
          height: h * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.5,
                    height: h *0.035,
                    child: const Text("Mutton Liver - Chunks",style: TextStyle(fontFamily: 'poppins',fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                  const Row(
                    children: [
                      Text("₹250",style: TextStyle(decoration: TextDecoration.lineThrough,fontFamily: 'poppins',fontSize: 12,color: Colors.grey),),
                      SizedBox(width: 5,),
                      Text("₹250",style: TextStyle(fontFamily: 'poppins',fontSize: 14,color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.bold),)
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("250g",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Colors.grey),),
                  changeQuantity(w, h),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}





Widget changeQuantity(w,h){
  return SizedBox(
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
  );
}