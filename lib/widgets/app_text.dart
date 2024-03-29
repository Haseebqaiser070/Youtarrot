import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize, letterSpacing, lineHeight;
  final FontWeight? fontWeight;
  final Color color;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
  const AppText({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.lineHeight,
    this.decoration,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight,
        decoration: decoration,
      ),
      textAlign: textAlign,
    );
  }
}
