
import 'package:anewmeat/controllers/products_controller.dart';
import 'package:anewmeat/views/authorized/products_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class categoryItem extends StatefulWidget {
  categoryItem({
    super.key,
    required this.categoryName,
    required this.imageURL,
    required this.h,
    required this.w,
    required this.productsController
  });

  double w;
  double h;
  String categoryName;
  String imageURL;
  ProductController productsController;

  @override
  State<categoryItem> createState() => _categoryItemState();
}


class _categoryItemState extends State<categoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    child: Container(
      width:widget.w * 0.19,
      height:widget.h * 0.1,
      margin:const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            width:widget.w * 0.16,
            height:widget.w * 0.16,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(widget.imageURL),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(height: 5,),
          Text(widget.categoryName,style:const TextStyle(fontFamily: 'poppins',fontSize: 16,),)
        ],
      ),
    ),
    onTap: (){
      setState((){
        widget.productsController.categoryName = widget.categoryName;
        widget.productsController.fetchCategoryProducts();
        Get.to(ProductsPage(
          heroImage: widget.imageURL,
          title: widget.categoryName,
        ));
      });
    },
  );
  }
}

