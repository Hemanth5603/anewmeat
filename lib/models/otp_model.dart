

class OtpModel {
  OtpModel({
    this.status,
    this.otp,
    this.existingUser,
  });
  String? status;
  int? otp;
  String? existingUser;
  
  OtpModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    otp = json['otp'];
    existingUser = json['existingUser'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['otp'] = otp;
    _data['existingUser'] = existingUser;
    return _data;
  }
}