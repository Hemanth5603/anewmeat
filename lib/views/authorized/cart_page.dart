import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/billing_controller.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/products_controller.dart';
import 'package:anewmeat/views/authentication/login.dart';
import 'package:anewmeat/views/authorized/coupon_page.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:anewmeat/views/utils/order_acknowledgement.dart';
import 'package:anewmeat/views/widgets/cart_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'package:googleapis/content/v2_1.dart' hide Row;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  BillingController billingController = Get.put(BillingController());
  var isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    
    setState(() {
      isLoading.value = true;
      //billingController.totalAmount  = billingController.calculateTotalAmount();
      //cartController.cartItemsLength = cartController.getCartLength();
      isLoading.value = false;

    });
    
  }
  @override
  Widget build(BuildContext context){
    
    CartController cartController = Get.put(CartController());
    ProductController productController = Get.put(ProductController());
    
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async{
        Get.back();
        await productController.fetchCategoryProducts();
        
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,),
              onPressed: (){
                Get.back();
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
                    const Icon(Icons.home_rounded,color: Color.fromARGB(255, 42, 42, 42),),
                    const SizedBox(width: 5,),
                    SizedBox(
                      width: w * 0.75,
                      child: Text(userController.userModel.address.toString(),style: TextStyle(fontFamily: 'poppins',fontSize: 14,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 55, 55, 55)),),
                    ),
                    const SizedBox(width: 10,),
                    const Icon(Icons.chevron_right_rounded)
                  ],
                ),
                const SizedBox(height: 15,),
              GestureDetector(
                  child: Container(
                    width: w,
                    height: h * 0.055,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:cartController.getCartModel!.products[0].items.isEmpty ? Colors.grey : Constants.customRed,
                    ), 
                    child:Obx(() => billingController.isLoading.value 
                    ? Center(
                      child: LoadingAnimationWidget.horizontalRotatingDots(
                        color: Colors.white, 
                        size: 30,
                      ),
                    ) 
                    : Center(
                      child: Text("Pay ₹${billingController.billModel?.toPay ?? ""}",style:const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),
                    ),)
                  ),
                  onTap: (){
                    billingController.openCheckout();
                    if(cartController.getCartModel!.productsLength != 0){
                      //billingController.createOrder();
                      //Get.to(const OrderAcknowledgement(),transition: Transition.downToUp,duration:const Duration(milliseconds: 400));
                    }else{
                      Fluttertoast.showToast(
                        msg: "Please add Items in cart",
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red
                      );
                    }
                  },
                )
              ],
            ),
          ),
          body:Obx(() => billingController.isLoading.value ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
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
                                Text("You have saved ₹${billingController.billModel?.savings.toString() ?? 0}!",style: const TextStyle(fontSize: 12,color: Colors.green,fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          Container(
                            width: w,
                            height:cartController.getCartModel!.products[0].items.length == 1
                            ? h * cartController.getCartModel!.products[0].items.length * 0.155 
                            : h * cartController.getCartModel!.products[0].items.length * 0.115,
                            color:const Color.fromARGB(255, 255, 255, 255),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Review Items",style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold),),
                                  SizedBox(height: h * 0.01,),
                                    Obx(()=> SizedBox(
                                      width: w, 
                                      height: h * cartController.getCartModel!.productsLength * 0.088,
                                      child: cartController.isLoading.value 
                                      ? const Center(
                                        child: CircularProgressIndicator(),
                                      ): ListView.builder(
                                        itemCount: cartController.getCartModel!.productsLength,
                                        itemBuilder: (context,index){
                                          return CartCard(w :w,h: h,
                                            index:index,
                                            id: cartController.getCartModel?.products[0].items[index].id ?? "",
                                            productName: cartController.getCartModel?.products[0].items[index].productName ?? "",
                                            productImage:cartController.getCartModel?.products[0].items[index].productImage ?? "",
                                            originalPrice: cartController.getCartModel?.products[0].items[index].originalPrice ?? "",
                                            finalPrice: cartController.getCartModel?.products[0].items[index].finalPrice ?? "",
                                            quantity:cartController.getCartModel?.products[0].items[index].quantity ?? "",
                                            oPrice: cartController.getCartModel?.products[0].items[index].oPrice ?? "",
                                            fPrice: cartController.getCartModel?.products[0].items[index].fPrice ?? "",
                                            cartController: cartController,
                                            billingController: billingController,
                                            isLoading: isLoading.value,
                                          );
                                        }
                                      )
                                    )
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Container(
                            width: w,
                            padding:const EdgeInsets.all(12),
                            height: h * 0.15,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Offers & Benefits",style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold),),
                                SizedBox(height: h * 0.02,),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      billingController.getCoupons();
                                    });
                                    Get.to(()=> const CouponPage());
                                  },
                                  child: Container(
                                    width: w,
                                    height: h * 0.06,
                                    padding:const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color.fromARGB(255, 48, 144, 51))
                                    ),
                                    child:const Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.local_offer_rounded,color: Color.fromARGB(255, 77, 160, 125),),
                                            SizedBox(width: 10,),
                                            Text("Apply Coupon",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 48, 144, 51)),),
                                          ],
                                        ),
                                        Icon(Icons.chevron_right_rounded,color: Color.fromARGB(255, 77, 160, 125),size: 30,)
                                      ],
                                    ),
                                  ),
                                ),
                                /*SizedBox(height: h * 0.02,),
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
                                ),*/
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.02,),
                          Container(
                            width: w,
                            height: h * 0.2,
                            color: Colors.white,
                            padding:const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Bill Summary",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                SizedBox(height: h * 0.01,),
                                billItem("Item Total","₹${billingController.billModel?.itemTotal ?? 0}",Colors.black),
                                SizedBox(height: h * 0.01,),
                                billItem("Delivery fee","₹${billingController.billModel?.deliveryFees ?? 0}",Colors.black),
                                SizedBox(height: h * 0.01,),
                                billItem("GST","₹${billingController.billModel?.gst ?? 0}",Colors.black),
                                const SizedBox(height:10,),
                                billItem("Coupon Discount","₹${billingController.billModel?.couponDicount ?? 0}", Colors.blue),
                               
                              ],
                            ),
                          ),
                         
                          const SizedBox(height: 15,),
                          const Text("CANCELLATION POLICY",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                          const SizedBox(height: 10,),
                          Container(
                            width: w,
                            color: Colors.white,
                            height: h * 0.12,
                            padding:const EdgeInsets.all(12),
                            child:const Column(
                              children: [
                                Text("100% Cancellation fee will be applicable only if you decide to cancel the order before it is dispatched.",
                                  style: TextStyle(fontSize: 10,color: Colors.grey),  
                                ),
                                SizedBox(height:10,),
                                Text("You can reschedule your delivery to a later time only until items are dispatched",
                                  style: TextStyle(fontSize: 10,color: Colors.grey),  
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
        ),
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







