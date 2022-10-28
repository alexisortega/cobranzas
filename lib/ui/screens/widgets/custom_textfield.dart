import 'package:cobranzas/constants.dart';
import 'package:flutter/material.dart';


class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final bool obscureText;
  final String hintText;

  const CustomTextfield({
    Key? key,
    required this.icon ,
    required this.obscureText,
    required this.hintText, 
    required TextEditingController ?controller, 
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
   
    return TextFormField(
    
    
      controller: TextEditingController() ,
      obscureText: obscureText,
      style: TextStyle(
      color: Constants.blackColor,
      
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
