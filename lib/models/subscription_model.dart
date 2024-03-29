class SubscriptionModel {
  String? price;
  String? id;
  String? time;
  String? user;
  String? createdOn;
  String? paymentId;

  SubscriptionModel({
    this.price,
    this.id,
    this.time,
    this.user,
    this.createdOn,
    this.paymentId,
  });

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    id = json['id'];
    time = json['time'];
    user = json['user'];
    paymentId = json['paymentId'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['id'] = id;
    data['time'] = time;
    data['user'] = user;
    data['paymentId'] = paymentId;
    data['createdOn'] = createdOn;
    return data;
  }
}
