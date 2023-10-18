import 'package:anewmeat/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
            physics:const NeverScrollableScrollPhysics(),
            headerSliverBuilder: (context,isScrolled){
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 5,left: 10),
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
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 228, 228, 228),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child:const Row(
                            children: [
                              Icon(Icons.search,color: const Color.fromARGB(255, 33, 33, 33),),
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
                        categoryItem(w, h,"https://dao54xqhg9jfa.cloudfront.net/OMS-Category/d654ce6f-3b1a-efb1-ce66-64b3a4afb655/original/Chicken_(1)_(1).png","Chicken"),
                        categoryItem(w, h,"https://dao54xqhg9jfa.cloudfront.net/OMS-Category/2119874c-38a6-df8c-22f1-5cd8a2eb4d80/original/Mutton_(1)_(1).png","Mutton"),
                        categoryItem(w, h,"https://dao54xqhg9jfa.cloudfront.net/OMS-Category/52ed9676-ec28-711e-dd8a-55d4ea17c324/original/Fish_(1)_(1)_(1).png","Sea Food"),
                        categoryItem(w, h,"https://dao54xqhg9jfa.cloudfront.net/OMS-Category/dfcc622c-de6a-7ad7-7329-23239fbab0af/original/Combo_(1).png","Combo"),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: w,
                    height: h * 0.34,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        productItem(w,h,"https://assets.tendercuts.in/product/P/R/63c42955-a41b-45ce-98e1-cb7510eeac4f.jpg",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                        productItem(w,h,"https://assets.tendercuts.in/product/C/H/a6b6b1db-2b6b-4129-a557-fbd9811c8888.webp",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                        productItem(w,h,"https://assets.tendercuts.in/product/P/R/f9d8d6f5-26df-44bf-9e1b-bf5687801870.jpg",
                          "Chicken Curry Cut","Cut and cleaned chicken for rich curries","250 grams","250","200","20",true,true
                        ),
                      ],
                    ),
                  ),
                )
              ];
            },
            body: Container(),
          ),
        ),
      ),
    );
  }
}



Widget categoryItem(w,h,imageURL,categoryName){
  return GestureDetector(
    child: Container(
      width: w * 0.2,
      height: h * 0.1,
      margin:const EdgeInsets.all(10),

      child: Column(
        children: [
          Container(
            width: w * 0.16,
            height: w * 0.16,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageURL),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(height: 5,),
          Text(categoryName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,),)
        ],
      ),
  
    ),
  );
}


Widget productItem(w,h,imageURL,productName,productDescription,quantity,originalPrice,finalPrice,offer,isOffer,isFreeDelivery){
  return Container(
    width: w * 0.5,
    margin:const EdgeInsets.only(left: 10,right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Stack(
      children: [
        Positioned(
          child: Container(
            width: w,
            height: h * 0.15,
            decoration: BoxDecoration(
              borderRadius:const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
              image: DecorationImage(
                image: NetworkImage(imageURL),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
        Positioned(
          top: h * 0.15,
          child:Container(
            width: w * 0.5,
            height: h * 0.15,
            padding:const EdgeInsets.all(10),
            decoration:const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(color: Color.fromARGB(255, 225, 225, 225),blurRadius: 10)
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productName,style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(productDescription,style: TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),maxLines: 2,overflow: TextOverflow.ellipsis,),
                Text(quantity,style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: const Color.fromARGB(255, 68, 68, 68)),maxLines: 1,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("₹" + originalPrice,style:const TextStyle(decoration: TextDecoration.lineThrough,fontFamily: 'poppins',fontSize: 14),),
                    const SizedBox(width: 5,),
                    Text("₹" + finalPrice,style: TextStyle(decoration: TextDecoration.lineThrough,fontFamily: 'poppins',fontSize: 16,color: Constants.customRed,fontWeight: FontWeight.bold),)
                  ],
                )
              ],
            ),
          )
        )
      ],
    ),

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