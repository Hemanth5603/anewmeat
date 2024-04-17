class UserModel {
  UserModel({
   this.status,
   this.name,
   this.number,
   this.email,
   this.address,
   this.id,
   this.latitude,
   this.longitude,
   this.V,
  });

  late final String? status;
  late final String? name;
  late final String? number;
  late final String? email;
  String? address;
  late final String? id;
  late final int? V;
  double? latitude;
  double? longitude;

  
  UserModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    name = json['name'];
    number = json['number'];
    email = json['email'];
    address = json['address'];
    id = json['id'];
    V = json['_v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['name'] = name;
    _data['number'] = number;
    _data['email'] = email;
    _data['address'] = address;
    _data['id'] = id;
    _data['_v'] = V;
    return _data;
  }
}