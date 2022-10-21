import 'package:cobranzas/constants.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;
  final TextEditingController controlador;

  CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    required this.controlador,
  }) : super(key: key);
  int valor = 10;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.blueAccent,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          color: Constants.blackColor.withOpacity(.3),
        ),
        hintText: hintText,
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),
    );
  }
}
