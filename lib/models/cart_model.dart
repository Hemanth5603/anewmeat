

import 'package:get/get.dart';

class CartModel {
  CartModel({
    required this.products,
    required this.totalAmount,
    required this.productsLength,
  });
  late List<Products> products;
  late double totalAmount = 0.0;
  late int productsLength = 0;
  
  CartModel.fromJson(Map<String, dynamic> json){ 
   products = (json['products'] as List?)?.map((i) => Products.fromJson(i)).toList() ?? [];
    productsLength = json['productsLength'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e)=>e.toJson()).toList();
    _data['productslength'] = productsLength;
    return _data;
  }
}

class Products {
  Products({
  required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.items,

  });
  late final String id;
  late final String name;
  late final String number;
  late final String email;
  late List<Items> items = [];

  
  Products.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['number'] = number;
    _data['email'] = email;
    _data['items'] = items.map((e)=>e.toJson()).toList();

    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.productName,
    required this.finalPrice,
    required this.originalPrice,
    required this.productImage,
    required this.quantity,
    required this.value,
    required this.fPrice,
    required this.oPrice
  });
  late final String id;
  late final String productName;
  late String finalPrice;
  late String originalPrice;
  late String productImage;
  late String fPrice;
  late String oPrice;
  late final String quantity;
  int? value = 1;

  
  Items.fromJson(Map<String, dynamic> json){
    id = json["id"];
    productName = json['productName'];
    finalPrice = json['finalPrice'];
    originalPrice = json['originalPrice'];
    productImage = json['productImage'];
    quantity = json['quantity'];
    value =  int.parse(json['value'] ?? '1');
    oPrice = json['oPrice'];
    fPrice = json['fPrice'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['productName'] = productName;
    _data['finalPrice'] = finalPrice;
    _data['originalPrice'] = originalPrice;
    _data['productImage'] = productImage;
    _data['quantity'] = quantity;
    _data['value'] = value;
    _data['fprice'] = fPrice;
    _data['oprice'] = oPrice;
    return _data;
  }
}




/*
class CartModel {
  CartModel({
    required this.productsLength,
    required this.products,
  });
  late final int productsLength;
  late final List<Products> products;
  late double totalAmount = 0.0;
  
  CartModel.fromJson(Map<String, dynamic> json){
    productsLength = json['productsLength'];
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productsLength'] = productsLength;
    _data['products'] = products.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Products {
  Products({
    required this.id,
    required this.name,
    required this.number,
    required this.email,
    required this.items,
    required this.V,
  });
  late final String id;
  late final String name;
  late final String number;
  late final String email;
  late final List<Items> items;
  late final int V;
  
  Products.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['number'] = number;
    _data['email'] = email;
    _data['items'] = items.map((e)=>e.toJson()).toList();
    _data['__v'] = V;
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.productName,
     this.categorieName,
    required this.finalPrice,
    required this.originalPrice,
    required this.fPrice,
    required this.oPrice,
    required this.productImage,
    required this.quantity,
    required this.value,
  });
  late final String id;
  late final String productName;
  late final Null categorieName;
  late final String finalPrice;
  late final String originalPrice;
  late final String fPrice;
  late final String oPrice;
  late final String productImage;
  late final String quantity;
  int? value = 1;
  
  Items.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productName = json['productName'];
    categorieName = null;
    finalPrice = json['finalPrice'];
    originalPrice = json['originalPrice'];
    fPrice = json['fPrice'];
    oPrice = json['oPrice'];
    productImage = json['productImage'];
    quantity = json['quantity'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['productName'] = productName;
    _data['categorieName'] = categorieName;
    _data['finalPrice'] = finalPrice;
    _data['originalPrice'] = originalPrice;
    _data['fPrice'] = fPrice;
    _data['oPrice'] = oPrice;
    _data['productImage'] = productImage;
    _data['quantity'] = quantity;
    _data['value'] = value;
    return _data;
  }
}
*/













