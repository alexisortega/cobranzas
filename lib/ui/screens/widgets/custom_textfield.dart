import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;

  const CustomTextfield({
    Key? key,
    required this.icon,
    required this.obscureText,
    required this.hintText,
    required TextEditingController controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: TextEditingController(),
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.black,
      ),

      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 3,
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.blue.withOpacity(.9),
        ),
        hintText: hintText,
      ),
    );
  }
}
