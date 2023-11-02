import 'package:anewmeat/controllers/products_controller.dart';
import 'package:anewmeat/views/authorized/product_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key,required this.heroImage,required this.title});
  final String title;
  final String heroImage;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    var productsController = Get.put(ProductController());
    int? productsCount;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title,style: const TextStyle(color: Colors.black,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
            IconButton(
              onPressed: (){
            }, icon:const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 30,))
          ],
        ),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon:const Icon(Icons.arrow_back_ios_rounded,color: Colors.black,size:25,),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: w,
                    height: h * 0.2,
                    decoration:BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.heroImage),
                        fit: BoxFit.cover
      
                      )
                    ),
                  ),
                  Container(
                    width: w,
                    height: h * 0.2,
                    decoration:const BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color.fromARGB(25, 255, 255, 255),
                          Color.fromARGB(139, 0, 0, 0),
                        ],
                        stops: [0.0,0.85]
                      )
              
      
                    ),
                  ),
                  Positioned(
                    bottom: 20,
      
                    left: 20,
                    child: Text("Fresh "+ widget.title,style: const TextStyle(fontFamily: 'poppins',fontSize: 25,fontWeight: FontWeight.w100,color: Colors.white
                    
                    ),),
                  ),
                  Positioned(
                    bottom: 20,right: 20,
                    child: Container(
                      padding:const EdgeInsets.symmetric(horizontal: 8),
                      width: w * 0.2,
                      height: h * 0.03,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 219, 219, 219)
                      ),
                      child:const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.filter_alt_outlined,color: Colors.black,size: 18,),
                          Text("Filters",style: TextStyle(fontFamily: 'poppins',fontSize: 12),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 0,),
              /*const Padding(
                padding: EdgeInsets.only(left: 10,top: 10),
                child: Text("Total 30 Items ",style: TextStyle(fontFamily: 'poppins',color: Colors.grey,fontSize: 18),),
              ),*/
              Container(
                margin:const EdgeInsets.all(8),
                height: h * 0.7,
                width: w,
                child: Obx(
                  () => productsController.isLoading.value 
                    ?const Center(
                      child: CircularProgressIndicator(),
                    )
                    : ListView.builder(
                      itemCount: productsController.productCategoryModel?.categoryProducts.length ?? 0,
                      itemBuilder:(context,index){
                        productsCount = productsController.productCategoryModel?.categoryProducts.length;
                        return ProductItem(w, h,
                            productsController.productCategoryModel?.categoryProducts[index].productImage,
                            productsController.productCategoryModel?.categoryProducts[index].productName,
                            productsController.productCategoryModel?.categoryProducts[index].productDesc,
                            productsController.productCategoryModel?.categoryProducts[index].pieces,
                            productsController.productCategoryModel?.categoryProducts[index].servings,
                            productsController.productCategoryModel?.categoryProducts[index].originalPrice,
                            productsController.productCategoryModel?.categoryProducts[index].finalPrice,
                        );
                    } ,
                  )
                )
              )
            ],
          )
        ),
      )
    );
  }
}







// ignore: non_constant_identifier_names
Widget ProductItem(w,h,imageURL,productName,productDesc,pieces,servings,originalPrice,finalPrice,){
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.only(bottom: h * 0.02),
      width: w,
      height: h * 0.35,
  
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow:const [
                BoxShadow(
                  color: Color.fromARGB(255, 190, 190, 190),
                  blurRadius: 5
                )
              ],
      ),
      child: Column(
        children: [
          Container(
            width: w,
            height: h * 0.17,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(imageURL),
                fit: BoxFit.cover,
              )
            ),
          ),
          Container(
            width: w,
            height: h * 0.18,
            padding:const EdgeInsets.only(left: 10,right: 10),
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.02,),
                Text(productName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
                Text(productDesc,style:const TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),),
                const SizedBox(height: 5,),
                Text("500g | $pieces pieces | Serves $servings",style:const TextStyle(fontFamily: 'poppins',fontSize: 12,color:  Color.fromARGB(255, 118, 118, 118)),),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Text("₹$originalPrice", style:const TextStyle(decoration: TextDecoration.lineThrough,fontSize: 14,fontFamily: 'poppins',color: Colors.grey),),
                    const SizedBox(width: 5,),
                    Text("₹$finalPrice",style:const TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold)),
                    const SizedBox(width: 10,),
                    const Text("20% Off",style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: Colors.green),)
                  ],
                ),
                Row(
  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("today 6 AM - 8 AM",style: TextStyle(fontFamily: 'poppins',fontSize: 14,color: Colors.grey),),
                    Container(
                      width: w * 0.2,
                      height: h * 0.04,
                      padding:const EdgeInsets.only(left: 10,right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:const Color.fromARGB(255, 206, 53, 65)
                      ),
                      child:const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add",style: TextStyle(fontFamily: 'poppins',color: Colors.white,fontSize: 15),),
                          Icon(Icons.add,color: Colors.white,size: 15,)
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
    ),
    onTap: (){
      Get.to(ProductPage(
        imageURL:imageURL,
        productName: productName ,
        productDesc: productDesc,
        price:finalPrice ,
      ),transition: Transition.rightToLeft,duration:const Duration(milliseconds: 300));
    },
  );
}







class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);
  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}