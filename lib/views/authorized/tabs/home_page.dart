import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/controllers/banners_controller.dart';
import 'package:anewmeat/controllers/billing_controller.dart';
import 'package:anewmeat/controllers/cart_controller.dart';
import 'package:anewmeat/controllers/category_controller.dart';
import 'package:anewmeat/controllers/products_controller.dart';
import 'package:anewmeat/controllers/user_controller.dart';
import 'package:anewmeat/views/authentication/location.dart';
import 'package:anewmeat/views/authorized/cart_page.dart';
import 'package:anewmeat/views/authorized/search_page.dart';
import 'package:anewmeat/views/components/all_button.dart';
import 'package:anewmeat/views/components/category_item.dart';
import 'package:anewmeat/views/components/product_card.dart';
import 'package:anewmeat/views/widgets/product_listing_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userController = Get.put(UserController());
  var categoryController = Get.put(CategoryController());
  var productController = Get.put(ProductController());
  var bannerController = Get.put(BannersController());
  var cartController = Get.put(CartController());
  var billingController = Get.put(BillingController());

  Future pullRefresh() async {
    await categoryController.fetchCategories();
  }

  @override
  void initState() {
    super.initState();
    
  }
 


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            billingController.checkCoupon("");
            cartController.getCartItems();
            Get.to(const CartPage());
          },
          child: Stack(
            children: [
              Container(
                width: w * 0.15,
                height: w * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color:Colors.white,
                  border: Border.all(color: Constants.customRed,width: 1)
                ),
                child:Icon(Icons.shopping_cart_outlined,color: Constants.customRed,size: 28,),
              ),
              /*Positioned(
                right:0,
                top:0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.black
                  ),
                  child: Center(
                    child:Text(cartController.getCartModel!.productsLength.toString() ?? "0",style: TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.white),)
                  ),
                )
              )*/
            ],
          ),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: pullRefresh,
          child:  DefaultTabController(
              length: 1,
              child: NestedScrollView(
                physics:const AlwaysScrollableScrollPhysics(),
                headerSliverBuilder: (contcext,isScrolled){
                  return [
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        child: Container(
                          margin:const EdgeInsets.only(top:30),
                          padding:const EdgeInsets.only(top: 5,left: 10),
                           child: Row(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.home,color: Color.fromARGB(255, 48, 48, 48),size: 35,),
                                  const SizedBox(width: 5,),
                                  SizedBox(
                                    width: w * 0.8,
                                    child:Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Home",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text(userController.userModel.address.toString(),style: const TextStyle(fontSize: 14,color: Colors.grey,overflow: TextOverflow.ellipsis),)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          Get.to(()=> const LocationScreen(), transition: Transition.downToUp,duration: 300.milliseconds);
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: GestureDetector(
                        child: Padding(
                          padding:const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                width: w * 0.94,
                                height: h * 0.05,
                                padding:const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color:const Color.fromARGB(255, 228, 228, 228),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child:const Row(
                                  children: [
                                    Icon(Icons.search,color: Color.fromARGB(255, 33, 33, 33),),
                                    SizedBox(width: 10,),
                                    Text("Search for Meat Items",style: TextStyle(fontFamily: 'poppins',fontSize: 14),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: (){
                          Get.to(const SearchPage(),transition: Transition.downToUp,duration: 300.milliseconds);
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: h * 0.22,
                        width: w,
                        child:Obx(() => 
                          bannerController.isLoading.value ? 
                           Center(
                            child: Container(child: Text("It's Been an Year"),),
                          ) :
                          CarouselSlider.builder(
                            itemCount: bannerController.bannerModel!.banners?.length ?? 0,
                            itemBuilder:(context,index,realIndex){
                              return Container(
                                width: w,
                                margin:const EdgeInsets.all(12),
                                height: h * 0.18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(bannerController.bannerModel!.banners![index]!.imageURL),
                                    fit: BoxFit.cover
                                  )
                                ),
                              );
                            } ,
                            options: CarouselOptions(
                              height: h * 0.22,
                              aspectRatio: 16/3,
                              viewportFraction: 0.9,
                              autoPlay: true,
                              autoPlayCurve: Curves.ease,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: const Duration(seconds: 1),
                              enlargeCenterPage: false,
                              onPageChanged: (index,reason){
                              }
                            ),
                          )
                        )
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: w,
                        height: h * 0.14,
                        margin:const EdgeInsets.only(top:10),
                        child:  ListView.builder(
                              scrollDirection: Axis.horizontal,
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
                   
                     SliverToBoxAdapter(
                      child:Padding(
                        padding:const EdgeInsets.only(left: 10.0,right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: w * 0.7,
                              child:const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Top Picks only for You !!",style: TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                  Text("Here's what you might like",style: TextStyle(fontFamily: 'poppins',fontSize: 16,))
                                ],
                              ),
                            ),
                            allButton(w, h)
                          ],
                        ),
                      ) ,
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        width: w,
                        height: h * 0.32,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productController.productModel?.products.length ?? 0,
                          itemBuilder: (context,index){
                            if(productController.productModel?.products[index].categorieName.toString() == "chicken" && productController.productModel?.products[index].isOffer == true){
                              return ProductCard(
                                w:w, 
                                h:h,
                                id: productController.productModel?.products[index].id ?? "",
                                imageURL:productController.productModel?.products[index].productImage ?? "",
                                productName: productController.productModel?.products[index].productName ?? "",
                                productDescription: productController.productModel?.products[index].productDesc ?? "",
                                finalPrice: productController.productModel?.products[index].finalPrice ?? "",
                                originalPrice: productController.productModel?.products[index].originalPrice ?? "",
                                offer: "20",
                                quantity: productController.productModel?.products[index].quantity ?? "",
                                isAdded: productController.productModel?.products[index].isAdded,
                                isFreeDelivery: productController.productModel?.products[index].isFreeDelivery ?? "",
                                isOffer: productController.productModel?.products[index].isOffer,
                                value:productController.productModel?.products[index].value ?? 0,
                                controller: cartController,
                              );
                            }else{
                              return Container();
                            }
                          },
                        )
                      ),
                    ),
                    SliverToBoxAdapter(
                      child:Padding(
                        padding:const EdgeInsets.all(10.0),
                        child: Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: w * 0.76,
                              child:const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Flat 50% off on SEA FOODS",style: TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold),),
                                  Text("Here's what you might like",style: TextStyle(fontFamily: 'poppins',fontSize: 16,))
                                ],
                              ),
                            ),
                            allButton(w,h)
                          ],
                        ),
                      ) ,
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        width: w,
                        height: h * 0.32,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: productController.productModel?.products.length ?? 0,
                          itemBuilder: (context,index){
                            if(productController.productModel?.products[index].categorieName.toString() == "mutton" && productController.productModel?.products[index].isOffer == true){
                              return ProductCard(
                                w:w, 
                                h:h,
                                id: productController.productModel?.products[index].id ?? "",
                                imageURL:productController.productModel?.products[index].productImage ?? "",
                                productName: productController.productModel?.products[index].productName ?? "",
                                productDescription: productController.productModel?.products[index].productDesc ?? "",
                                finalPrice: productController.productModel?.products[index].finalPrice ?? "",
                                originalPrice: productController.productModel?.products[index].originalPrice ?? "",
                                offer: "20",
                                quantity: productController.productModel?.products[index].quantity ?? "",
                                isAdded: productController.productModel?.products[index].isAdded,
                                isFreeDelivery: productController.productModel?.products[index].isFreeDelivery ?? "",
                                isOffer: productController.productModel?.products[index].isOffer,
                                value:productController.productModel!.products[index].value ?? 0,
                                controller: cartController,
                              );
                            }else{
                              return Container();
                            }
                          },
                        )
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding:const EdgeInsets.all(10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: w * 0.75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("ALL Products",style: TextStyle(fontSize:20,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                                  Text("${productController.productModel?.products.length} Total Items",style: const TextStyle(fontFamily: 'poppins',fontSize: 14,color: Colors.grey))
                                ],
                              ),
                            ),
                            allButton(w, h),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    Obx(
                      () => productController.isLoading.value 
                        ?const Center(
                          child: CircularProgressIndicator(),
                        )
                        : ListView.builder(
                          itemCount: productController.productModel?.products.length ?? 0,
                          itemBuilder:(context,index){
                            return ProductListingItem(
                              w:w, 
                              h:h,
                              id: productController.productModel?.products[index].id ?? "",
                              imageUrl:productController.productModel?.products[index].productImage ?? "",
                              productName:productController.productModel?.products[index].productName ?? "", 
                              productDesc: productController.productModel?.products[index].productDesc ?? "",
                              quantity: productController.productModel?.products[index].quantity ?? "", 
                              originalPrice: productController.productModel?.products[index].originalPrice ?? "",
                              finalPrice:productController.productModel?.products[index].finalPrice ?? "",
                              offer:productController.productModel?.products[index].discount ?? "",
                              isOffer:true, 
                              servings: productController.productModel?.products[index].servings ?? "",
                              pieces: productController.productModel?.products[index].pieces ?? "",
                              isFreeDelivery:productController.productModel?.products[index].isFreeDelivery ?? "",
                              isAdded:productController.productModel?.products[index].isAdded,
                              cartController: cartController,

                            );
                          } ,
                        )
                    )
                  ],
                )
              ),
            ),
          ),
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



