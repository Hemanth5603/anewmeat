class CouponModel {
  CouponModel({
    required this.coupons,
  });
  late final List<Coupons> coupons;
  
  CouponModel.fromJson(Map<String, dynamic> json){
    coupons = List.from(json['coupons']).map((e)=>Coupons.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coupons'] = coupons.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Coupons {
  Coupons({
    required this.id,
    required this.name,
    required this.code,
    required this.discount,
    required this.minAmount,
    required this.applyForFirstOrder,
    required this.conditions,
    required this.V,
    required this.maxAmount,
  });
  late final String id;
  late final String name;
  late final String code;
  late final String discount;
  late final String minAmount;
  late final String applyForFirstOrder;
  late final List<Conditions> conditions;
  late final int V;
  late final String maxAmount;
  
  Coupons.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    code = json['code'];
    discount = json['discount'];
    minAmount = json['minAmount'];
    applyForFirstOrder = json['applyForFirstOrder'];
    conditions = List.from(json['conditions']).map((e)=>Conditions.fromJson(e)).toList();
    V = json['__v'];
    maxAmount = json['maxAmount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['code'] = code;
    _data['discount'] = discount;
    _data['minAmount'] = minAmount;
    _data['applyForFirstOrder'] = applyForFirstOrder;
    _data['conditions'] = conditions.map((e)=>e.toJson()).toList();
    _data['__v'] = V;
    _data['maxAmount'] = maxAmount;
    return _data;
  }
}

class Conditions {
  Conditions({
    required this.description,
  });
  late final String description;
  
  Conditions.fromJson(Map<String, dynamic> json){
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    return _data;
  }
}

class _V {
  _V({
    required this.description,
  });
  late final String description;
  
  _V.fromJson(Map<String, dynamic> json){
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['description'] = description;
    return _data;
  }
}