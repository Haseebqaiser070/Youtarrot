import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ok_tarrot/constants/app_svgs.dart';
import 'package:ok_tarrot/widgets/app_text.dart';

class AppButton extends StatelessWidget {
  final double height;
  final String text;
  final VoidCallback? onTap;
  final bool isLoading;
  const AppButton({
    Key? key,
    this.height = 70,
    required this.text,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        child: Center(
          child: isLoading
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 15,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: text,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                    SvgPicture.string(
                      AppSvgs.arrowForward,
                      // ignore: deprecated_member_use
                      color: Colors.white,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
