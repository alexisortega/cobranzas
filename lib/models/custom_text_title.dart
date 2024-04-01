import 'package:cobranzas/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextTitle extends StatelessWidget {
  final String title;

  final double size;

  const CustomTextTitle({
    super.key,
    required this.title,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.aldrich(
        textStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: size,
          color: Constants.blueColor,
        
        ),
      ),
    );
  }
}
