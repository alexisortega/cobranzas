import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String text;
 final TextStyle font;

  const CustomText({
    super.key,
    required this.text,
    required this.font,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, style: font);
  }
}
