import 'package:cloud_firestore/cloud_firestore.dart';

class CombinationModel {
  String? card1;
  String? card2;

  Timestamp? createdOn;
  String? message;

  CombinationModel({this.card1, this.card2, this.createdOn, this.message});

  CombinationModel.fromJson(Map<String, dynamic> json) {
    card1 = json['card1'];
    card2 = json['card2'];

    createdOn = json['created_on'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['card1'] = card1;
    data['card2'] = card2;

    data['created_on'] = createdOn;
    data['message'] = message;
    return data;
  }
}
