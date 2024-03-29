import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/controllers/registration_controllers/forget_password_controller.dart';

import '../../../constants/app_spacing.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_field.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: GetBuilder<ForgetPasswordController>(
            init: ForgetPasswordController(),
            builder: (_) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/splash_logo.png",
                    width: 200,
                  ),
                  AppSpacing.heightSpace30,
                  AppField(
                    controller: _.email,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AppSpacing.heightSpace50,
                  AppButton(
                    isLoading: _.isLoading,
                    onTap: () async {
                      await _.validate();
                    },
                    text: "RESET PASSWORD",
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
