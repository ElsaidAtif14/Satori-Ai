import 'package:flutter/material.dart';

class CustomGlowRing extends StatelessWidget {
  final double size;
  final Widget? child;
  final Color borderColor;
  final double borderWidth;

  const CustomGlowRing({
    super.key,
    required this.size,
    this.child,
    this.borderColor = Colors.blueGrey,
    this.borderWidth = 0.70,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor.withOpacity(0.5), // إمكانية التحكم في الشفافية
          width: borderWidth,
        ),
      ),
      child: Center(
        child: UnconstrainedBox(
          child: child,
        ),
      ),
    );
  }
}