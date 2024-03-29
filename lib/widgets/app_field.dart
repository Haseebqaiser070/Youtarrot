import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isObsecure;
  final TextInputType? keyboardType;
  const AppField({
    Key? key,
    this.controller,
    this.hintText,
    this.suffixIcon,
    this.isObsecure = false,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      style: GoogleFonts.poppins(
        color: Colors.white,
      ),
      obscureText: isObsecure,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: Colors.white,
        ),
        suffixIcon: suffixIcon,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
