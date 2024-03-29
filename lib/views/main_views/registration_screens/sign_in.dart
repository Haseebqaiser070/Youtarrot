import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ok_tarrot/constants/app_svgs.dart';
import 'package:ok_tarrot/controllers/registration_controllers/signin_controller.dart';
import 'package:ok_tarrot/views/main_views/homepage.dart';
import 'package:ok_tarrot/views/main_views/registration_screens/forget_password.dart';
import 'package:ok_tarrot/views/main_views/registration_screens/sign_up.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

import '../../../constants/app_spacing.dart';

import '../../../widgets/app_button.dart';
import '../../../widgets/app_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: GetBuilder<SignInController>(
              init: SignInController(),
              builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "logo",
                      child: Image.asset(
                        "assets/images/splash_logo.png",
                        width: 200,
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    AppField(
                      controller: _.email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email",
                    ),
                    AppSpacing.heightSpace20,
                    AppField(
                      controller: _.password,
                      hintText: "Password",
                      isObsecure: _.isObsecure,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: InkWell(
                        onTap: () {
                          _.changeObsecurity();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: SvgPicture.string(
                            _.isObsecure ? AppSvgs.hide : AppSvgs.openEye,
                            // ignore: deprecated_member_use
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    AppSpacing.heightSpace10,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          Get.offAll(
                            () => const ForgetPassword(),
                          );
                        },
                        child: const AppText(
                          text: "Forgot Password?",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    InkWell(
                      onTap: () {
                        Get.offAll(
                          transition: Transition.zoom,
                          () => const Homepage(),
                        );
                      },
                      child: const AppText(
                        text: "Skip",
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppSpacing.heightSpace30,
                    AppButton(
                      isLoading: _.isLoading,
                      onTap: () async {
                        await _.validate();
                      },
                      text: "SIGN IN",
                    ),
                    AppSpacing.heightSpace30,
                    const AppText(
                      text: "Or sign in with",
                      fontSize: 16,
                    ),
                    AppSpacing.heightSpace10,
                    InkWell(
                      onTap: _.googleSignLoading
                          ? null
                          : () async {
                              await _.googleSignin();
                            },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: _.googleSignLoading
                            ? const SpinKitCircle(
                                color: Colors.white,
                              )
                            : SvgPicture.string(
                                AppSvgs.google,
                              ),
                      ),
                    ),
                    AppSpacing.heightSpace10,
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(),
                        children: [
                          const TextSpan(
                            text: "Don't have an account ? ",
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAll(
                                  () => const SignUp(),
                                );
                              },
                            text: "Sign Up",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffBFB341),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
