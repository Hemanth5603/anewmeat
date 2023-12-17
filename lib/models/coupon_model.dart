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
    required this.conditions,
    required this.V,
  });
  late final String id;
  late final String name;
  late final String code;
  late final List<Conditions> conditions;
  late final int V;
  
  Coupons.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    name = json['name'];
    code = json['code'];
    conditions = List.from(json['conditions']).map((e)=>Conditions.fromJson(e)).toList();
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['code'] = code;
    _data['conditions'] = conditions.map((e)=>e.toJson()).toList();
    _data['__v'] = V;
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