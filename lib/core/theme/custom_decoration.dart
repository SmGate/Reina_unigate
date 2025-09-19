import 'package:flutter/material.dart';
import 'package:unigate/core/theme/app_colors.dart';

BoxDecoration customContainerDecoration({
  Color color = AppColors.white,
  double borderRadius = 0,
  double shadowBlurRadius = 0,
  double shadowSpreadRadius = 0,
  Color borderColor = AppColors.neutralVeryLight,
  Color shadowColor = AppColors.neutralVeryLight,
}) {
  return BoxDecoration(
    color: color,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(borderRadius),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: shadowBlurRadius,
        spreadRadius: shadowSpreadRadius,
        offset: const Offset(0, 0), // Shadow on all sides
      ),
    ],
  );
}
