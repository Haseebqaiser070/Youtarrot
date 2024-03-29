import 'package:cloud_firestore/cloud_firestore.dart';

class TutorialModel {
  Timestamp? createdOn;
  String? id;
  String? title;
  String? description;
  TutorialModel({this.createdOn, this.description, this.id, this.title});
  TutorialModel.fromJson(Map<String, dynamic> json) {
    createdOn = json['created_on'];
    id = json['id'];
    title = json['Tutorial_title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['created_on'] = createdOn;
    data['id'] = id;
    data['Tutorial_title'] = title;
    data['description'] = description;
    return data;
  }
}
