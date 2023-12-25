import 'dart:convert';
import 'package:get/get.dart';

List<UserModel> productFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));


class UserModel{
  UserModel({
    this.id,
    this.name,
    this.phoneNumber,
    this.email,
    this.status,
    this.address,
    this.latitute,
    this.longitude

  });
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? email;
  final String? status;
  double? latitute;
  double? longitude;
  String? address = "null".obs();


  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      id: json["message"]["_id"], 
      name: json["message"]["name"],
      status: json["status"],
      phoneNumber: json["message"]["number"], 
      email: json["message"]["email"]
    );
  }
}

