class BillModel {
  BillModel({
    required this.itemTotal,
    required this.toPay,
    required this.deliveryFees,
    required this.gst,
    required this.couponDicount,
    required this.couponApplicable,
    required this.savings,
  });
  late final int itemTotal;
  late final int toPay;
  late final int deliveryFees;
  late final int gst;
  late final int couponDicount;
  late final bool couponApplicable;
  late final int savings;
  
  BillModel.fromJson(Map<String, dynamic> json){
    itemTotal = json['itemTotal'];
    toPay = json['toPay'];
    deliveryFees = json['deliveryFees'];
    gst = json['gst'];
    couponDicount = json['couponDicount'];
    couponApplicable = json['couponApplicable'];
    savings = json['savings'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['itemTotal'] = itemTotal;
    _data['toPay'] = toPay;
    _data['deliveryFees'] = deliveryFees;
    _data['gst'] = gst;
    _data['couponDicount'] = couponDicount;
    _data['couponApplicable'] = couponApplicable;
    _data['savings'] = savings;
    return _data;
  }
}