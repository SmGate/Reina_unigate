import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unigate/core/theme/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final TextStyle displayMediumBold = GoogleFonts.inter(
      fontWeight: FontWeight.w700,
      fontSize: 28,
      height: 1.0,
      letterSpacing: -0.56,
      color: AppColors.oceanBlue);

  static final TextStyle displaySmall500 = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.0,
      letterSpacing: -0.56,
      color: AppColors.oceanBlue);

  static final TextStyle displayMediumMedium = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 28,
      height: 1.0,
      letterSpacing: -0.56,
      color: AppColors.blackish);

  static final TextStyle displayMediumMedium20 = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      height: 1.0,
      letterSpacing: -0.56,
      color: AppColors.blackish);

  static final TextStyle displayMediumMedium12 = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.0,
      letterSpacing: -0.56,
      color: AppColors.blackish);

  static final TextStyle displayMediumMedium18 = GoogleFonts.inter(
      fontWeight: FontWeight.w500,
      fontSize: 18,
      height: 1.0,
      letterSpacing: -0.56,
      color: AppColors.blackish);

  static final TextStyle heading3Light = GoogleFonts.inter(
      fontWeight: FontWeight.w300,
      fontSize: 16,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.neutralDarkGray);

  static final TextStyle heading3Light12 = GoogleFonts.inter(
      fontWeight: FontWeight.w300,
      fontSize: 12,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.neutralDarkGray);

  static final TextStyle heading3White = GoogleFonts.inter(
      fontWeight: FontWeight.w300,
      fontSize: 14,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.white);

  static final TextStyle inter400White16 = GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.white);

  static final TextStyle inter400Black16 = GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.blackish);

  static final TextStyle inter600Black16 = GoogleFonts.inter(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.blackish);

  static final TextStyle heading3Regular = GoogleFonts.inter(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.0,
      letterSpacing: 0.0,
      color: AppColors.neutralDarkGray);
}
