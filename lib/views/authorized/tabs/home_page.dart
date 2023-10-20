import 'package:anewmeat/constants/app_constants.dart';
import 'package:anewmeat/views/components/all_button.dart';
import 'package:anewmeat/views/components/category_item.dart';
import 'package:anewmeat/views/components/order_again_card.dart';
import 'package:anewmeat/views/components/product_card.dart';
import 'package:anewmeat/views/components/product_listing_card.dart';
import 'package:anewmeat/views/products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 1,
          child: NestedScrollView(
            headerSliverBuilder: (context,isScrolled){
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:const EdgeInsets.only(top: 5,left: 10),
                     child: Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.home,color: Color.fromARGB(255, 48, 48, 48),size: 35,),
                            const SizedBox(width: 5,),
                            SizedBox(
                              width: w * 0.7,
                              child:const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Home",style: TextStyle(fontSize: 18,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                                  Text("11-9-29A1, Daspalla Hills, Siripuram, visakhapatnam",style: TextStyle(fontFamily: 'poppins',fontSize: 14,color: Colors.grey,overflow: TextOverflow.ellipsis),)
                                ],
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: (){

                          }, 
                          icon:Icon(Icons.person_2_rounded,color: Constants.customRed,size: 35,)
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding:const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: w * 0.8,
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
                        const SizedBox(width: 10,),
                        GestureDetector(
                          child: Container(
                            width: w * 0.1,
                            height: w * 0.1,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromARGB(255, 201, 201, 201)),
                              borderRadius: BorderRadius.circular(12)
                              
                            ),
                            child: Center(
                              child: Icon(Icons.filter_alt_outlined,color: Constants.customRed,),
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: h * 0.15,
                    width: w,
                    color: const Color.fromARGB(255, 215, 215, 215),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: w,
                    height: h * 0.15,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(const ProductsPage());
                          },
                          child: categoryItem(w, h,"https://assets.tendercuts.in/category/M/u/96059dfe-3207-4fda-9b96-b99f07eea4dc.jpg","Mutton")),
                        GestureDetector(
                          onTap: (){
                          },
                          child: categoryItem(w, h,"https://assets.tendercuts.in/category/C/h/444c122b-a639-48ff-8078-5b9b5af74596.jpg","Chicken")
                        ),
                        categoryItem(w, h,"https://assets.tendercuts.in/category/S/e/f9a8cb8c-ac77-44dd-9be2-e0e80c0db433.jpg","Sea Food"),
                        categoryItem(w, h,"https://assets.tendercuts.in/category/C/o/fb564e26-8a77-4350-8e38-f5073ec8eae6.jpg","Combo"),
                      ],
                    ),
                  ),
                ),
                 SliverToBoxAdapter(
                  child:Padding(
                    padding:const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: w * 0.75,
                          child:const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Looking for Frest Meat?",style: TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold),),
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
                    height: h * 0.34,
                    child: ListView(
                      scrollDirection: Axis.horizontal, 
                      children: [
                        productCard(w,h,"https://assets.tendercuts.in/product/P/R/63c42955-a41b-45ce-98e1-cb7510eeac4f.jpg",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                        productCard(w,h,"https://assets.tendercuts.in/product/C/H/a6b6b1db-2b6b-4129-a557-fbd9811c8888.webp",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,false
                        ),
                        productCard(w,h,"https://assets.tendercuts.in/product/P/R/f9d8d6f5-26df-44bf-9e1b-bf5687801870.jpg",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child:Padding(
                    padding:const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    height: h * 0.34,
                    child: ListView(
                      scrollDirection: Axis.horizontal, 
                      children: [
                        productCard(w,h,"https://www.licious.in/_next/image?url=https%3A%2F%2Fdao54xqhg9jfa.cloudfront.net%2FOMS-ProductMerchantdising%2F1ea5ff1f-52f3-c7aa-953a-a4d287e40247%2Foriginal%2Fp0_tile_images-15_(2).jpg&w=384&q=75",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                        productCard(w,h,"https://www.licious.in/_next/image?url=https%3A%2F%2Fdao54xqhg9jfa.cloudfront.net%2FOMS-ProductMerchantdising%2F4f3ba1b6-7a8d-5938-5415-07789653b203%2Foriginal%2FMurrel_Fry_Cut.jpg&w=384&q=75",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,false
                        ),
                        productCard(w,h,"https://www.licious.in/_next/image?url=https%3A%2F%2Fassets.licious.in%2FOMS-ProductMerchantdising%2F7eb50f35-dfa1-87db-aa2e-04eda16267f3%2Foriginal%2F1694450355159.jpg&w=384&q=75",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                        productCard(w,h,"https://www.licious.in/_next/image?url=https%3A%2F%2Fassets.licious.in%2FOMS-ProductMerchantdising%2F5b5f3fc7-a78e-c207-b643-24fb3123f92d%2Foriginal%2F1694596151996.jpg&w=384&q=75",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding:const EdgeInsets.all(10),
                    child:Row(
                      children: [
                        SizedBox(
                          width: w * 0.75,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Order Again",style: TextStyle(fontSize:20,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                              Text("You Ordered 3 Items",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Colors.grey))
                            ],
                          ),
                        ),
                        allButton(w, h),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: w,
                    height: h * 0.2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        orderAgainCard(w, h,"Chicken/Fish/Combo","1250","4 aug 2023","1 Chicken . 1 Fish Combo with Prawns",),
                        orderAgainCard(w, h,"Chicken/Fish/Combo","1250","4 aug 2023","1 Chicken . 1 Fish Combo with Prawns",),
                        orderAgainCard(w, h,"Chicken/Fish/Combo","1250","4 aug 2023","1 Chicken . 1 Fish Combo with Prawns",),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding:const EdgeInsets.all(10),
                    child:Row(
                      children: [
                        SizedBox(
                          width: w * 0.75,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("ALL Products",style: TextStyle(fontSize:20,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                              Text("26 Total Items",style: TextStyle(fontFamily: 'poppins',fontSize: 16,color: Colors.grey))
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
                ListView(
                  children: [
                    productListingItem(w,h,"https://assets.tendercuts.in/product/P/R/63c42955-a41b-45ce-98e1-cb7510eeac4f.jpg",
                      "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true),

                    productListingItem(w,h,"https://assets.tendercuts.in/product/C/H/a6b6b1db-2b6b-4129-a557-fbd9811c8888.webp",
                      "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true),

                    productListingItem(w,h,"https://assets.tendercuts.in/product/S/F/75fcc3f5-8f77-4cb5-97e2-b82ff73ff9f3.webp",
                      "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true),
                    
                    productListingItem(w,h,"https://assets.tendercuts.in/product/P/R/1806bbf4-76f4-48b2-a2b8-618b526bf044.webp",
                      "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true),
                    
                    productListingItem(w,h,"https://assets.tendercuts.in/product/R/M/2fa6b2bd-884e-4ecb-ac32-09bd7134a854.webp",
                      "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true),

                    productListingItem(w,h,"https://assets.tendercuts.in/product/C/H/7bfc5e2d-3857-4f3e-a736-222c7a617b67.webp",
                      "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true),
                  ],
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