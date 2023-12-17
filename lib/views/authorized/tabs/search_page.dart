import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/category_controller.dart';
import 'package:anewmeat/controllers/products_controller.dart';
import 'package:anewmeat/views/components/category_item.dart';
import 'package:anewmeat/views/widgets/product_listing_card.dart';
import 'package:anewmeat/views/widgets/search_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController.fetchAllProducts();
  }
  @override
  Widget build(BuildContext context) {
    var categoryController = Get.put(CategoryController());
    var productController = Get.put(ProductController());
    var cartController = Get.put(CartController());
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:const Text("Search",style: TextStyle(fontFamily: 'poppins',fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Padding(
          padding:const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: w,
                height: h * 0.06,
                padding: const EdgeInsets.only(top: 10,left: 10),
                margin:const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey.shade100,
                ),
                child:const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search for categories, tem etc ...",
                    hintStyle: TextStyle(fontFamily: 'poppins',fontSize: 16,color: const Color.fromARGB(255, 104, 104, 104))
                  ),
                  cursorColor: Colors.black,
                ),
              ),
              const Text("Shop by Category",style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold),),
              Container(
                    width: w,
                    height: h * 0.15,
                    margin:const EdgeInsets.only(top:10),
                    child: Obx(
                      () => categoryController.isLoading.value 
                      ? const Center(
                        child: CircularProgressIndicator(),
                      ) 
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics:const NeverScrollableScrollPhysics(),
                          itemCount: categoryController.categoryModel?.categories.length ?? 0,
                          itemBuilder:(context,index){
                            return categoryItem(
                              w:w,
                              h: h,
                              imageURL: categoryController.categoryModel!.categories[index].imageUrl,
                              categoryName: categoryController.categoryModel!.categories[index].name!,
                              productsController: productController,
                            );
                          },
                      )
                    )
                  ),
              Container(
                width: w,
                height: h * 0.525,
                child: Obx(() => cartController.isLoading.value
                ? const Center(
                  child: CircularProgressIndicator(),
                )
                : ListView.builder(
                  itemCount: productController.productModel?.products.length ?? 0,
                  itemBuilder: (context,index){
                    return SearchCard(
                      w:w,
                      h:h,
                      name: productController.productModel?.products[index].productName ?? "",
                      price:productController.productModel?.products[index].finalPrice ?? "",
                      index: index,
                      imageUrl: productController.productModel?.products[index].productImage ?? "",
                      pieces: productController.productModel?.products[index].pieces ?? "",
                      cartController: cartController,
                    );
                    } ,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


