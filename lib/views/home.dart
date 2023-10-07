import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w,
                height: h * 0.07,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 6,),
                    const Icon(Icons.home_outlined,color: Colors.black,size: 40,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 8,left: 8),
                          child: Text("Home",style: TextStyle(fontFamily: 'poppins',fontSize: 18,fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8),
                          child: SizedBox(
                            width: w * 0.65,
                            child:const Text("11-9-29A1, Daspalla Hills, Siripuram, Visakhapatnam - 530002",style: TextStyle(overflow: TextOverflow.ellipsis,fontFamily: 'poppins',fontSize: 12,fontWeight: FontWeight.bold,color: Colors.grey),)),
                        )
                      ],
                    ),
                    const SizedBox(width: 25,),
                    Padding(
                      padding: const EdgeInsets.only(top: 0,),
                      child: IconButton(
                        onPressed: (){

                        },
                        icon:const Icon(Icons.person,size: 40,color: Color.fromARGB(216, 90, 172, 93)),
                      )
                    )
                  ],
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(12), 
                child: Row(
                  children: [
                    Container(
                      width: w * 0.8,
                      height: h * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color:const Color.fromARGB(144, 208, 208, 208)
                      ),
                      child:Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.search,color: Color.fromARGB(255, 24, 24, 24),),
                          ),
                          SizedBox(width: 6,),
                          Container(
                            width: w * 0.6,
                            child:const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(fontFamily: 'sen',fontSize: 16,color: Colors.grey),
                                
                              ),
                              keyboardType: TextInputType.name,
                            ),
                          )
                          
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        width: w * 0.1,
                        height: w * 0.1,
                        margin:const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade400,width: 1),
                        ),
                        child:const Center(
                          child: Icon(Icons.filter_alt_outlined,color: Color.fromARGB(216, 90, 172, 93),),
                        ),
                      ),
                      onTap: (){

                      },
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.red,
                width: w,
                height: h * 0.15,

              ),
              SizedBox(height: 15,),
              Container(
                width: w,
                height: h * 0.1,
                child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    
                  ),
                  children: [
                    gridItem(w,h,"assets/images/chicken.png","Chicken"),
                    gridItem(w,h,"assets/images/mutton.png","Mutton"),
                    gridItem(w,h,"assets/images/fish.png","Fish"),
                    gridItem(w,h,"assets/images/combo.png","Combo"),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01,),
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  width: w,
                  height: h * 0.4,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(146, 221, 221, 221),
                  ),

                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Looking for Fresh Meat?",style: TextStyle(fontFamily: 'poppins',fontSize: 20,fontWeight: FontWeight.bold),),
                      const Text("Here's what you might like",style: TextStyle(fontFamily: 'poppins',fontSize: 14,color: Colors.grey),),
                      const SizedBox(height: 10,),
                      SizedBox(
                        width: w,
                        height: h * 0.22,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            productItem(w,h)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      )
    );
  }
}

Widget gridItem(w,h,imagePath,title){
  return Container(
    height: h * 0.18,
    width:  w * 0.1,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(image: AssetImage(imagePath),width: 60,),
        SizedBox(height: 0,),
        Text(title,style: TextStyle(fontFamily: 'poppins',fontSize: 14,),)
      ],
    ),

  );
}


Widget productItem(w,h){
  return Container(
    width: w * 0.5,
    height: h * 0.15,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),

    ),
    child: Stack(
      children: [
        Container(
          width: w,
          height: h * 0.12,
          decoration:BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            image: DecorationImage(
              image: NetworkImage("https://www.licious.in/_next/image?url=https%3A%2F%2Fdao54xqhg9jfa.cloudfront.net%2FOMS-ProductMerchantdising%2F4c8af11d-43ac-cc1d-77b6-5fc567a51c5d%2Foriginal%2FPDP_12._Lamb_Curry_Cut_-_(Small)_(1).jpg&w=384&q=75"),
              fit: BoxFit.cover
            )
          ) ,
          
        ),
        Positioned(
          top: h* 0.12,
          child: Container(
            width: w,
            height: h * 0.15,
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}