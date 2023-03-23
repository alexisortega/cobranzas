import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  TextStyle font;

  CustomText({
    super.key,
    required this.text,
    required this.font,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: font);
  }
}
