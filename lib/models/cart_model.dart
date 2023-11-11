
class CartModel {
  CartModel({
    required this.products,
  });
  late final List<Products> products;
  
  CartModel.fromJson(Map<String, dynamic> json){
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    required this.finalPrice,
    required this.originalPrice,
    required this.productImage,
    required this.quantity,
    required this.value,
  });
  late final String id;
  late final String productName;
  late final String? finalPrice;
  late final String? originalPrice;
  late final String productImage;
  late final String quantity;
  int? value = 1;
  
  Items.fromJson(Map<String, dynamic> json){
    id = json["id"];
    productName = json['productName'];
    finalPrice = json['finalPrice'];
    originalPrice = json['originalPrice'];
    productImage = json['productImage'];
    quantity = json['quantity'];
    value =  int.parse(json['value']);
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
    return _data;
  }
}



































/*class CartModel {
  String? id;
  String? name;
  String? number;
  String? email;
  List<Items>? items;

  CartModel({
    this.id,
    this.name,
    this.number,
    this.email,
    this.items,
  });
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json["_id"]?.toString();
    name = json['name']?.toString();
    number = json['number']?.toString();
    email = json['email']?.toString();
    items: json["items"] == null ? [] : List<Items>.from(json["items"]!.map((x) => Items.fromJson(x)));
  /*if (json['items'] != null) {
  final v = json['items'];
  final arr0 = <Items>[];
  v.forEach((v) {
  arr0.add(Items.fromJson(v));
  });
    items = arr0;
    }*/
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["_id"] = id;
    data['name'] = name;
    data['number'] = number;
    data['email'] = email;
    if (items != null) {
      final v = items;
      final arr0 = [];
  v?.forEach((v) {
  arr0.add(v.toJson());
  });
      data['items'] = arr0;
    }
    return data;
  }
}



class Items {
  String? productName;
  String? finalPrice;
  String? originalPrice;
  String? productImage;
  String? quantity;
  int? value;

  Items({
    this.productName,
    this.finalPrice,
    this.originalPrice,
    this.productImage,
    this.quantity,
    this.value,
  });
  Items.fromJson(Map<String, dynamic> json) {
    productName = json['productName']?.toString();
    finalPrice = json['finalPrice']?.toString();
    originalPrice = json['originalPrice']?.toString();
    productImage = json['productImage']?.toString();
    quantity = json['quantity']?.toString();
    value = json['value'];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['productName'] = productName;
    data['finalPrice'] = finalPrice;
    data['originalPrice'] = originalPrice;
    data['productImage'] = productImage;
    data['quantity'] = quantity;
    data['value'] = value;
    return data;
  }
}
*/
