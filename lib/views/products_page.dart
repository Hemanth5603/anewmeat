import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
      double h = MediaQuery.of(context).size.height;
      double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text("Mutton",style: TextStyle(color: Colors.black,fontFamily: 'poppins',fontWeight: FontWeight.bold),),
            IconButton(
              onPressed: (){
            }, icon:const Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 30,))
          ],
        ),
        leading: IconButton(
          onPressed: (){

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
                    decoration:const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage("https://assets.tendercuts.in/product/G/T/2ce52567-a770-4b70-848f-c38f5e528c39.webp"),
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
                  const Positioned(
                    bottom: 20,
      
                    left: 20,
                    child: Text("Fresh Mutton",style: TextStyle(fontFamily: 'poppins',fontSize: 25,fontWeight: FontWeight.w100,color: Colors.white
                    
                    ),),
                  ),
                  Positioned(
                    bottom: 20,right: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
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
              SizedBox(height: 0,),
              Padding(
                padding: const EdgeInsets.only(left: 10,top: 10),
                child: Text("Total 30 Items ",style: TextStyle(fontFamily: 'poppins',color: Colors.grey,fontSize: 18),),
              ),
              Container(
                margin: EdgeInsets.all(15),
                height: h * 0.614,
                width: w,
                child: ListView(
                  children: [
                    Item(w,h),
                    Item(w,h),
                    Item(w,h),
                    Item(w,h),
                    Item(w,h),
                  ],
                ),
              )
      
            ],
          )
        ),
      )
    );
  }
}

Widget Item(w,h){
  return Container(
    margin: EdgeInsets.only(bottom: h * 0.06),
    width: w,
    height: h * 0.33,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 190, 190, 190),
                blurRadius: 5
              )
            ],
    ),
    child: Column(
      children: [
        Container(
          width: w,
          height: h * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            image: DecorationImage(
              image: NetworkImage("https://assets.tendercuts.in/product/P/R/44e5fc66-bd7b-437c-aa09-c6873382bd09.webp"),
              fit: BoxFit.cover,
            )
          ),
        ),
        Container(
          width: w,
          height: h * 0.18,
          padding: EdgeInsets.only(left: 10,right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.02,),
              Text("Mutton Curry Cut (Medium Sized)",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold),),
              Text("Cut and cleaned mutton for rich curries",style: TextStyle(fontFamily: 'poppins',fontSize: 10,color: Colors.grey),),
              SizedBox(height: 5,),
              Text("500g | 14-22 pieces | Serves 4",style:TextStyle(fontFamily: 'poppins',fontSize: 12,color: const Color.fromARGB(255, 118, 118, 118)),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("₹609",style: TextStyle(fontFamily: 'poppins',fontSize: 16,fontWeight: FontWeight.bold)),
                  SizedBox(width: 10,),
                  Text("20% Off",style: TextStyle(fontFamily: 'poppins',fontSize: 12,color: Colors.green),)
                ],
              ),
              SizedBox(height:0),
              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("today 6 AM - 8 AM",style: TextStyle(fontFamily: 'poppins',fontSize: 14,color: Colors.grey),),
                  Container(
                    width: w * 0.2,
                    height: h * 0.04,
                    padding: EdgeInsets.only(left: 10,right: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 206, 53, 65)
                    ),
                    child: Row(
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