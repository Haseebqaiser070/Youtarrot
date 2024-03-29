import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/services/registration_services.dart';
import 'package:ok_tarrot/utils/app_snackbar.dart';

class SignInController extends GetxController {
  final RegistrationServices _services = RegistrationServices();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isObsecure = true;
  changeObsecurity() {
    isObsecure = !isObsecure;
    update();
  }

  bool isLoading = false;
  validate() async {
    if (email.text.isEmpty || !email.text.isEmail) {
      AppSnackbar.snackBar(title: "Error", message: "Enter valid Email!");
    } else if (password.text.isEmpty || password.text.length < 6) {
      AppSnackbar.snackBar(title: "Error", message: "Enter 8 characters password!");
    } else {
      isLoading = true;
      update();
      await _services.login(email: email.text, password: password.text);
      isLoading = false;
      update();
    }
  }

  bool googleSignLoading = false;
  googleSignin() async {
    googleSignLoading = true;
    update();
    await _services.googleLogin();
    googleSignLoading = false;
    update();
  }
}
