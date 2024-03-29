import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/services/registration_services.dart';

import '../../utils/app_snackbar.dart';

class SignupController extends GetxController {
  final RegistrationServices _services = RegistrationServices();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObsecure = true;
  changeObsecurity() {
    isObsecure = !isObsecure;
    update();
  }

  bool isLoading = false;
  validate() async {
    if (username.text.isEmpty) {
      AppSnackbar.snackBar(title: "Error", message: "Username is required field!");
    } else if (email.text.isEmpty || !email.text.isEmail) {
      AppSnackbar.snackBar(title: "Error", message: "Enter valid Email!");
    } else if (password.text.isEmpty || password.text.length < 8) {
      AppSnackbar.snackBar(title: "Error", message: "Enter 8 characters password!");
    } else {
      isLoading = true;
      update();
      await _services.register(
        userName: username.text,
        email: email.text,
        password: password.text,
      );
      isLoading = false;
      update();
    }
  }
}
