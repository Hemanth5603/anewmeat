import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:anewmeat/views/widgets/cart_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:skeletonizer/skeletonizer.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    cartController.getCartItems();
  }
  @override
  Widget build(BuildContext context){
    bool isLoading = false;
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
        body: Skeletonizer(
          enabled: isLoading,
          child: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                    width: w,
                    height: h + h/1.5,
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
                          height: h * cartController.getCartModel!.products[0].items.length * 0.15,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Review Items",style: TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold),),
                                SizedBox(height: h * 0.02,),
                                SizedBox(
                                  width: w,
                                  height: h * cartController.getCartModel!.products[0].items.length * 0.11,
                                  child: Obx(() => cartController.isLoading.value
                                  ?  Center(
                                    child: Container(
                                      width: 50 ,
                                      height: 50,
                                      child:const CircularProgressIndicator(),
                                    ),
                                  )
                                  : ListView.builder(
                                   
                                    itemCount: cartController.getCartModel!.products[0].items.length,
                                    itemBuilder: (context,index){
                                      return CartCard(w :w,h: h,
                                        index:index,
                                        id: cartController.getCartModel?.products[0].items[index].id ?? "",
                                        productName: cartController.getCartModel?.products[0].items[index].productName ?? "",
                                        productImage:cartController.getCartModel?.products[0].items[index].productImage ?? "",
                                        originalPrice: cartController.getCartModel?.products[0].items[index].originalPrice ?? "",
                                        finalPrice: cartController.getCartModel?.products[0].items[index].finalPrice ?? "",
                                        quantity:cartController.getCartModel?.products[0].items[index].quantity ?? "",
                                        cartController: cartController,
                                        isLoading: isLoading,
                                      );
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







