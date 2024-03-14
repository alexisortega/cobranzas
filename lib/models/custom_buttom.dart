import 'package:flutter/material.dart';

class CustomButtom extends StatefulWidget {
  const CustomButtom({
    super.key,
    this.onTap,
    this.color,
    this.borderRadius,
    required this.child,
    this.height = 50,
    this.width = 50,
    this.margin,
    this.padding,
  });
  final BorderRadiusGeometry? borderRadius;

  final EdgeInsetsGeometry? margin;

  final EdgeInsetsGeometry? padding;

  final Color? color;

  final VoidCallback? onTap;

  final double height;

  final double width;

  final Widget child;

  @override
  State<CustomButtom> createState() => CustomButtomState();
}

class CustomButtomState extends State<CustomButtom> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.color ?? Colors.white,
      borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          alignment: Alignment.center,
          margin: widget.margin,
          padding: widget.margin,
          width: widget.width,
          height: widget.height,
        ),
      ),
    );
  }
}