import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/services/registration_services.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';

class ForgetPasswordController extends GetxController {
  final RegistrationServices _services = RegistrationServices();
  TextEditingController email = TextEditingController();
  bool isLoading = false;
  validate() async {
    if (email.text.isEmpty || !email.text.isEmail) {
      AppSnackbar.snackBar(title: "Error", message: "Enter valid Email!");
    } else {
      isLoading = true;
      update();
      await _services.forgetPassword(email.text);
      isLoading = false;
      update();
    }
  }
}
