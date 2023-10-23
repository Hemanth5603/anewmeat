class ProductModel {
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
        required this.v,
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
    final int? v;

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
            pieces: pieces ?? this.pieces,
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
            isFreeDelivery: json["isFreeDelivery"],
            servings: json["servings"],
            pieces: json["pieces"],
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
        "servings": servings,
        "pieces": pieces,
        "__v": v,
    };

    @override
    String toString(){
        return "$id, $productName, $productDesc, $finalPrice, $originalPrice, $productImage, $discount, $isFreeDelivery, $servings, $pieces, $v, ";
    }
}
