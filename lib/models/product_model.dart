

/*class ProductModel {
    ProductModel({
        required this.products,
    });

    final List<Product> products;

    ProductModel copyWith({
        List<Product>? products,
    }) {
        return ProductModel(
            products: products ?? this.products,
        );
    }

    factory ProductModel.fromJson(Map<String, dynamic> json){ 
        return ProductModel(
            products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "products": products.map((x) => x?.toJson()).toList(),
    };

    @override
    String toString(){
        return "$products, ";
    }
}

class Product {
    Product({
        required this.id,
        required this.productName,
        required this.productDesc,
        required this.finalPrice,
        required this.originalPrice,
        required this.productImage,
        required this.discount,
        required this.isFreeDelivery,
        required this.servings,
        required this.pieces,
        required this.categorieName,
        required this.value,
        required this.quantity,
        required this.isOffer,
        required this.v,
        this.isAdded,

    });

    final String? id;
    final String? productName;
    final String? productDesc;
    final String? finalPrice;
    final String? originalPrice;
    final String? productImage;
    final String? discount;
    final String? isFreeDelivery;
    final String? servings;
    final String? pieces;
    final String? quantity;
    final String? categorieName;
    int? value = 1;
    final int? v;
    bool? isAdded = false;
    bool isOffer;

    

    Product copyWith({
        String? id,
        String? productName,
        String? productDesc,
        String? finalPrice,
        String? originalPrice,
        String? productImage,
        String? discount,
        String? isFreeDelivery,
        String? servings,
        String? pieces,
        String? categorieName,
        String? quantity,
        bool? isOffer,

        int? v,
    }) {
        return Product(
            id: id ?? this.id,
            productName: productName ?? this.productName,
            productDesc: productDesc ?? this.productDesc,
            finalPrice: finalPrice ?? this.finalPrice,
            originalPrice: originalPrice ?? this.originalPrice,
            productImage: productImage ?? this.productImage,
            discount: discount ?? this.discount,
            isFreeDelivery: isFreeDelivery ?? this.isFreeDelivery,
            servings: servings ?? this.servings,
            quantity: quantity ?? this.quantity,
            isOffer: isOffer ?? this.isOffer,
            categorieName: categorieName ?? this.categorieName,
            pieces: pieces ?? this.pieces,
            value: value ?? value,
            v: v ?? this.v,
        );
    }

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["_id"],
            productName: json["productName"],
            productDesc: json["productDesc"],
            finalPrice: json["finalPrice"],
            originalPrice: json["originalPrice"],
            productImage: json["productImage"],
            discount: json["discount"],
            quantity: json["quantity"],
            categorieName: json["categorieName"],
            isOffer: json["isOffer"],
            isFreeDelivery: json["isFreeDelivery"],
            servings: json["servings"],
            pieces: json["pieces"],
            value: json["value"],
            v: json["__v"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productName": productName,
        "productDesc": productDesc,
        "finalPrice": finalPrice,
        "originalPrice": originalPrice,
        "productImage": productImage,
        "discount": discount,
        "isFreeDelivery": isFreeDelivery,
        "quantity" : quantity,
        "servings": servings,
        "isOffer": isOffer,
        "pieces": pieces,
        "categorieName": categorieName,
        "value": value,
        "__v": v,
    };

    @override
    String toString(){
        return "$id, $productName, $productDesc, $finalPrice, $originalPrice, $productImage, $discount, $quantity,$isFreeDelivery, $servings, $pieces, $v, ";
    }
}


*/



class ProductModel {
  ProductModel({
    required this.products,
  });
  late final List<Products> products;
  
  ProductModel.fromJson(Map<String, dynamic> json){
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
    required this.productName,
    required this.productDesc,
    required this.categorieName,
    required this.finalPrice,
    required this.originalPrice,
    required this.productImage,
    required this.discount,
    required this.isFreeDelivery,
    required this.servings,
    required this.pieces,
    required this.V,
    required this.quantity,
    required this.isOffer,
  });
  late final String id;
  late final String productName;
  late final String productDesc;
  late final String categorieName;
  late final String finalPrice;
  late final String originalPrice;
  late final String productImage;
  late final String discount;
  late final String isFreeDelivery;
  late final String servings;
  late final String pieces;
  late final int V;
  late final String quantity;
  late final bool isOffer;
  int? value = 0;
  bool isAdded = false;
  
  Products.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    productName = json['productName'];
    productDesc = json['productDesc'];
    categorieName = json['categorieName'];
    finalPrice = json['finalPrice'];
    originalPrice = json['originalPrice'];
    productImage = json['productImage'];
    discount = json['discount'];
    isFreeDelivery = json['isFreeDelivery'];
    servings = json['servings'];
    pieces = json['pieces'];
    V = json['__v'];
    quantity = json['quantity'];
    isOffer = json['isOffer'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['productName'] = productName;
    _data['productDesc'] = productDesc;
    _data['categorieName'] = categorieName;
    _data['finalPrice'] = finalPrice;
    _data['originalPrice'] = originalPrice;
    _data['productImage'] = productImage;
    _data['discount'] = discount;
    _data['isFreeDelivery'] = isFreeDelivery;
    _data['servings'] = servings;
    _data['pieces'] = pieces;
    _data['__v'] = V;
    _data['quantity'] = quantity;
    _data['isOffer'] = isOffer;
    return _data;
  }
}