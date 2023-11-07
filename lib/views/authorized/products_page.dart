import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/products_controller.dart';
import 'package:anewmeat/views/authorized/product_page.dart';
import 'package:anewmeat/views/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

CartController cartController = Get.put(CartController());

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
    var cartController = Get.put(CartController());
    var productsController = Get.put(ProductController());
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton:  Visibility(
        visible: !cartController.isCartEmpty,
        child: Container(
          width: w * 0.92,
          height: h * 0.05,
          padding:const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child:const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("5 Items",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Colors.white),),
                Text("View Cart",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Colors.white),)
              ],
            ),
          ),
        ),
      ),
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
                    child: Text("Fresh ${widget.title}",style: const TextStyle(fontFamily: 'poppins',fontSize: 25,fontWeight: FontWeight.w100,color: Colors.white
                    
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
                        return ProductCard(
                            w:w, 
                            h:h,
                            imageURL: productsController.productCategoryModel?.categoryProducts[index].productImage,
                            productName: productsController.productCategoryModel?.categoryProducts[index].productName,
                            productDesc: productsController.productCategoryModel?.categoryProducts[index].productDesc,
                            pieces : productsController.productCategoryModel?.categoryProducts[index].pieces,
                            servings: productsController.productCategoryModel?.categoryProducts[index].servings,
                            originalPrice: productsController.productCategoryModel?.categoryProducts[index].originalPrice,
                            finalPrice: productsController.productCategoryModel?.categoryProducts[index].finalPrice,
                            value: productsController.productCategoryModel?.categoryProducts[index].value,
                            quantity: productsController.productCategoryModel?.categoryProducts[index].quantity,
                            cartController: cartController,
                        );
                    },
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