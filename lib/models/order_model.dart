/*class OrderModel {
  OrderModel({
    required this.orders,
  });
  List<Orders> orders = [];
  
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
    required this.isDelivered,
    required this.V,
  });
  String? id;
  String? uId;
  String? orderId;
  String? name;
  String? number;
  String? date;
  String? time;
  late final List<Items> items;
  String? totalAmount;
  String? paymentMethod;
  String? couponCode;
  String? deliveryFee;
  DeliveryAddress? deliveryAddress;
  bool? isDelivered;
  int? V;
  
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
    _data['items'] = items?.map((e)=>e.toJson()).toList();
    _data['totalAmount'] = totalAmount;
    _data['payment_method'] = paymentMethod;
    _data['coupon_code'] = couponCode;
    _data['delivery_fee'] = deliveryFee;
    _data['delivery_address'] = deliveryAddress?.toJson();
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
}*/




class OrderModel {
  OrderModel({
    required this.orders,
  });
  List<Orders> orders = [];
  
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
    required this.date,
    required this.time,
    required this.name,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.orderId,
    required this.couponCode,
    required this.number,
    required this.totalAmount,
    required this.deliveryFee,
    required this.items,
    required this.orderAccepted,
    required this.outForDelivery,
    required this.orderDelivered,
    required this.deliveryLatitude,
    required this.deliveryLongitude,
    required this.adminLatitude,
    required this.adminLongitude,
    required this.deliveryPersonPhone,
    required this.timestamp,
    required this.V,
  });
  String? id;
  String? date;
  String? time;
  String? name;
  String? paymentMethod;
  String? deliveryAddress;
  String? orderId;
  String? couponCode;
  String? number;
  String? totalAmount;
  String? deliveryFee;
  String? timestamp;
  late final List<Items> items;
  bool? orderAccepted;
  bool? outForDelivery;
  bool? orderDelivered;
  double? deliveryLatitude;
  double? deliveryLongitude;
  double? adminLatitude;
  double? adminLongitude;
  String? deliveryPersonPhone;
  int? V;
  
  Orders.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    date = json['date'];
    time = json['time'];
    name = json['name'];
    paymentMethod = json['payment_method'];
    deliveryAddress = json['delivery_address'];
    orderId = json['order_id'];
    couponCode = json['coupon_code'];
    number = json['number'];
    totalAmount = json['total_amount'];
    deliveryFee = json['delivery_fee'];
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    orderAccepted = json['order_accepted'];
    outForDelivery = json['out_for_delivery'];
    orderDelivered = json['order_delivered'];
    deliveryLatitude = json['delivery_latitude'];
    deliveryLongitude = json['delivery_longitude'];
    adminLatitude = json['admin_latitude'];
    adminLongitude = json['admin_longitude'];
    deliveryPersonPhone = json['delivery_person_phone'];
    timestamp = json['timestamp'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['date'] = date;
    _data['time'] = time;
    _data['name'] = name;
    _data['payment_method'] = paymentMethod;
    _data['delivery_address'] = deliveryAddress;
    _data['order_id'] = orderId;
    _data['coupon_code'] = couponCode;
    _data['number'] = number;
    _data['total_amount'] = totalAmount;
    _data['delivery_fee'] = deliveryFee;
    _data['items'] = items.map((e)=>e.toJson()).toList();
    _data['order_accepted'] = orderAccepted;
    _data['out_for_delivery'] = outForDelivery;
    _data['order_delivered'] = orderDelivered;
    _data['delivery_latitude'] = deliveryLatitude;
    _data['delivery_longitude'] = deliveryLongitude;
    _data['admin_latitude'] = adminLatitude;
    _data['admin_longitude'] = adminLongitude;
    _data['delivery_person_phone'] = deliveryPersonPhone;
    _data['timestamp'] = timestamp;
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
    required this.fprice,
    required this.oprice,
  });
  late final String id;
  late final String productName;
  late final String finalPrice;
  late final String originalPrice;
  late final String productImage;
  late final String quantity;
  late final int value;
  late final String fprice;
  late final String oprice;
  
  Items.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productName = json['productName'];
    finalPrice = json['finalPrice'];
    originalPrice = json['originalPrice'];
    productImage = json['productImage'];
    quantity = json['quantity'];
    value = json['value'];
    fprice = json['fprice'];
    oprice = json['oprice'];
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
    _data['fprice'] = fprice;
    _data['oprice'] = oprice;
    return _data;
  }
}