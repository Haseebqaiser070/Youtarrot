import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ok_tarrot/constants/app_spacing.dart';
import 'package:ok_tarrot/views/main_views/registration_screens/sign_in.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/pass_changed_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: AppSpacing.defaultPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppText(
                  text: "X\n\nReset Password",
                  textAlign: TextAlign.center,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
                Column(
                  children: [
                    // const FittedBox(
                    //   child: AppText(
                    //     text: "Password Changed!",
                    //     fontSize: 30,
                    //     fontWeight: FontWeight.w900,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    AppSpacing.heightSpace20,
                    const AppText(
                      text:
                          "We have just sent you an email with the password reset link for your account. Please check your inbox and follow the instructions provided to reset your password.\n\nIf you don't see the email, please check your spam or junk folder.",
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    AppSpacing.heightSpace30,
                    FilledButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Get.offAll(
                          () => const SignIn(),
                        );
                      },
                      child: const Center(
                        child: AppText(
                          text: "Back to Login",
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: AppText(
                    //     text: "Meaning of the card ",
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.w700,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    AppSpacing.heightSpace10,
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: AppText(
                        text: "Life repeats itself senselessly - until you become attentive, it will repeat itself like a wheel.",
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
