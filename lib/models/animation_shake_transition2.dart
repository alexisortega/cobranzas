import 'package:flutter/material.dart';

class ShakeTransition2 extends StatefulWidget {
  const ShakeTransition2({
    super.key,
    this.duration = const Duration(milliseconds: 700),
    required this.child,
    this.offset = 140,
    this.axis = Axis.horizontal,
    this.left = true,
  });

  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;
  final bool left;

  @override
  State<ShakeTransition2> createState() => ShakeTransition2State();
}

class ShakeTransition2State extends State<ShakeTransition2> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      builder: (context, value, Widget? child) {
        return Transform.translate(
          offset: widget.left
              ? Offset((-value * widget.offset), (value * widget.offset))
              : Offset((value * widget.offset), (-value * -widget.offset)),
          child: child,
        );
      },
      tween: Tween(begin: 1.0, end: 0.0),
      duration: widget.duration,
      curve: Curves.easeInOut,
      child: widget.child,
    );
  }
}
