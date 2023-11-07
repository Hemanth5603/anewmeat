


class CartModel {
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
  if (json['items'] != null) {
  final v = json['items'];
  final arr0 = <Items>[];
  v.forEach((v) {
  arr0.add(Items.fromJson(v));
  });
    items = arr0;
    }
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

