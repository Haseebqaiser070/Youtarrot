class UserModel {
  String? name;
  String? email;
  String? profile;
  String? id;
  String? gender;
  String? phoneCode;
  String? phoneCountry;
  String? phoneNumber;
  String? createdAt;
  String? updatedAt;
  UserModel({
    this.name,
    this.email,
    this.profile,
    this.id,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.gender,
    this.phoneCode,
    this.phoneCountry,
  });

  UserModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    email = map['email'];
    profile = map['profile_picture'];
    id = map['id'];
    gender = map['gender'];
    phoneCode = map['phoneCode'];
    phoneCountry = map['phone_country'];
    phoneNumber = map['phone_number'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
  }
}
