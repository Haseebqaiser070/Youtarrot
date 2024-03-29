import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ok_tarrot/services/registration_services.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';

class UpdateProfileController extends GetxController {
  final RegistrationServices _services = RegistrationServices();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String phoneCode = '';
  String phoneCountry = '';
  File? image;
  String picUrl = '';
  pickImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    await ImagePicker.platform
        .getImage(
      source: ImageSource.gallery,
    )
        .then(
      (value) {
        if (value == null) {
        } else {
          image = File(value.path);
          update();
        }
      },
    );
  }

  String selectedVal = "Male";
  selectGender(String value) {
    selectedVal = value;
    gender.text = selectedVal;
    update();
  }

  bool isLoading = false;

  updateProfile(String id) async {
    if (name.text.isEmpty || name.text.length < 3) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter valid name!");
    } else if (email.text.isEmpty || !email.text.isEmail) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter valid email!");
    } else if (phoneNumber.text.isEmpty) {
      AppSnackbar.snackBar(title: "Error", message: "Please enter your complete phone number!");
    } else {
      isLoading = true;
      update();

      await _services.updateProfile(
        userName: name.text,
        email: email.text,
        gender: gender.text,
        phoneNumber: phoneNumber.text,
        profile: image,
        id: id,
        picUrl: picUrl,
        phoneCode: phoneCode,
        phoneCountry: phoneCountry,
      );
      isLoading = false;
      update();
    }
  }
}
