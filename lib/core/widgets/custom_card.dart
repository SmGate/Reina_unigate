import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final Color? color;
  final BorderRadius? borderRadius;

  const CustomCard({
    super.key,
    required this.child,
    this.elevation = 4,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadiusValue = borderRadius ?? BorderRadius.circular(12);

    return SizedBox(
      width: double.infinity,
      child: Card(
        // 👇 This removes the default 4px outer gap around Card
        margin: EdgeInsets.zero,
        elevation: elevation,
        surfaceTintColor: color ?? Colors.white,
        color: color ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadiusValue,
        ),
        clipBehavior: Clip.antiAlias, // keeps rounded corners crisp
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadiusValue,
          ),
          child: child,
        ),
      ),
    );
  }
}
