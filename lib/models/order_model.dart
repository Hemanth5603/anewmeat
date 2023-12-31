class OrderModel {
  OrderModel({
    required this.orders,
  });
  late final List<Orders> orders;
  
  OrderModel.fromJson(Map<String, dynamic> json){
    orders = List.from(json['orders']).map((e)=>Orders.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orders'] = orders.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Orders {
  Orders({
    required this.id,
    required this.uId,
    required this.orderId,
    required this.name,
    required this.number,
    required this.date,
    required this.time,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.couponCode,
    required this.deliveryFee,
    required this.deliveryAddress,
    required this.V,
  });
  late final String id;
  late final String uId;
  late final String orderId;
  late final String name;
  late final String number;
  late final String date;
  late final String time;
  late final List<Items> items;
  late final String totalAmount;
  late final String paymentMethod;
  late final String couponCode;
  late final String deliveryFee;
  late final DeliveryAddress deliveryAddress;
  late final int V;
  
  Orders.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    uId = json['uId'];
    orderId = json['order_id'];
    name = json['name'];
    number = json['number'];
    date = json['date'];
    time = json['time'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    totalAmount = json['totalAmount'];
    paymentMethod = json['payment_method'];
    couponCode = json['coupon_code'];
    deliveryFee = json['delivery_fee'];
    deliveryAddress = DeliveryAddress.fromJson(json['delivery_address']);
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['uId'] = uId;
    _data['order_id'] = orderId;
    _data['name'] = name;
    _data['number'] = number;
    _data['date'] = date;
    _data['time'] = time;
    _data['items'] = items.map((e)=>e.toJson()).toList();
    _data['totalAmount'] = totalAmount;
    _data['payment_method'] = paymentMethod;
    _data['coupon_code'] = couponCode;
    _data['delivery_fee'] = deliveryFee;
    _data['delivery_address'] = deliveryAddress.toJson();
    _data['__v'] = V;
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.productName,
    required this.categorieName,
    required this.finalPrice,
    required this.originalPrice,
    required this.productImage,
    required this.quantity,
    required this.value,
  });
  late final String id;
  late final String productName;
  late final String categorieName;
  late final String finalPrice;
  late final String originalPrice;
  late final String productImage;
  late final String quantity;
  late final String value;
  
  Items.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productName = json['productName'];
    categorieName = json['categorieName'];
    finalPrice = json['finalPrice'];
    originalPrice = json['originalPrice'];
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
    _data['productImage'] = productImage;
    _data['quantity'] = quantity;
    _data['value'] = value;
    return _data;
  }
}

class DeliveryAddress {
  DeliveryAddress({
    required this.doorNumber,
    required this.street,
    required this.area,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.id,
  });
  late final String doorNumber;
  late final String street;
  late final String area;
  late final String city;
  late final String state;
  late final String zipCode;
  late final String id;
  
  DeliveryAddress.fromJson(Map<String, dynamic> json){
    doorNumber = json['door_number'];
    street = json['street'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['door_number'] = doorNumber;
    _data['street'] = street;
    _data['area'] = area;
    _data['city'] = city;
    _data['state'] = state;
    _data['zip_code'] = zipCode;
    _data['_id'] = id;
    return _data;
  }
}