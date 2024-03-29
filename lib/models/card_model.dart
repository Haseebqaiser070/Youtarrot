import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  String? cardImage;
  Timestamp? createdOn;
  String? subCategory;
  String? cardName;
  String? description;
  String? id;
  String? category;

  CardModel(
      {this.cardImage,
      this.createdOn,
      this.subCategory,
      this.cardName,
      this.description,
      this.id,
      this.category});

  CardModel.fromJson(Map<String, dynamic> json) {
    cardImage = json['cardImage'];
    createdOn = json['created_on'];
    subCategory = json['sub_category'];
    cardName = json['card_name'];
    description = json['description'];
    id = json['id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cardImage'] = cardImage;
    data['created_on'] = createdOn;
    data['sub_category'] = subCategory;
    data['card_name'] = cardName;
    data['description'] = description;
    data['id'] = id;
    data['category'] = category;
    return data;
  }
}
