import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  const ShakeTransition({
    super.key,
    required this.duration,
    required this.child,
    required this.offset,
    required this.axis,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: duration,
      curve: Curves.bounceOut,
      tween: Tween(begin: 1.0, end: 0.0),
      child: child,
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(value * offset, 0.0)
              : Offset(0.0, value * offset),
          child: child,
        );
      },
    );
  }
}
