import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/app_spacing.dart';
import '../../../../constants/app_svgs.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/my_appbar.dart';

class Definition extends StatelessWidget {
  final String description;
  const Definition({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xff151515),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [
            0.6,
            1.0,
          ],
          colors: [
            const Color(0xff151515),
            const Color(0xff9DADDF).withOpacity(0.5),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppbar(
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: Image.asset(
              "assets/images/splash_logo.png",
              height: 60,
              width: 60,
            ),
          ),
          action: InkWell(
            onTap: () => Get.back(),
            child: SvgPicture.string(
              AppSvgs.arrowBackward,
            ),
          ),
        ),
        body: Padding(
          padding: AppSpacing.defaultPadding,
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppSpacing.heightSpace30,
                AppText(
                  text: "tutorial".tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Colors.white.withOpacity(0.5),
                ),
                AppSpacing.heightSpace30,
                // AppText(
                //   text: "tutorial".tr,
                //   fontWeight: FontWeight.w500,
                //   fontSize: 20,
                //   decoration: TextDecoration.underline,
                // ),
                // AppSpacing.heightSpace30,
                HtmlWidget(
                  description,
                  textStyle: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
