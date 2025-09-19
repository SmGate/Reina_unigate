import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class SearchBarWid extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const SearchBarWid({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const int maxLines = 1;
    final int minLines = math.min(1, maxLines);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutralLight),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        style: AppTextStyles.inter400Black16,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.heading3Regular,
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.neutralDarkGray),
          border: InputBorder.none,
          contentPadding: AppSpacing.paddingH12V12,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
