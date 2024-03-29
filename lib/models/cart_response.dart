class CartResponse {
  CartResponse({
    required this.status,
    required this.message,
  });
  late final String status;
  late final List<Message> message;
  
  CartResponse.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = List.from(json['message']).map((e)=>Message.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Message {
  Message({
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
  
  Message.fromJson(Map<String, dynamic> json){
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
  late final String value;
  
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