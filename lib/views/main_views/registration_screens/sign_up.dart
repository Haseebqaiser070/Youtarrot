import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ok_tarrot/controllers/registration_controllers/signup_controller.dart';
import 'package:ok_tarrot/views/main_views/registration_screens/sign_in.dart';
import 'package:ok_tarrot/widgets/app_button.dart';
import 'package:ok_tarrot/widgets/app_field.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

import '../../../constants/app_spacing.dart';
import '../../../constants/app_svgs.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: GetBuilder<SignupController>(
              init: SignupController(),
              builder: (_) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/splash_logo.png",
                      width: 200,
                    ),
                    AppSpacing.heightSpace30,
                    const AppText(
                      text: "SIGN UP",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                    AppSpacing.heightSpace30,
                    AppField(
                      controller: _.username,
                      hintText: "Username",
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
                    AppSpacing.heightSpace30,
                    AppSpacing.heightSpace30,
                    AppButton(
                      isLoading: _.isLoading,
                      onTap: () async {
                        await _.validate();
                      },
                      text: "SIGN UP",
                    ),
                    AppSpacing.heightSpace30,
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.poppins(),
                        children: [
                          const TextSpan(
                            text: "Already have account? ",
                          ),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAll(
                                  () => const SignIn(),
                                );
                              },
                            text: "Sign In",
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
