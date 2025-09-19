import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function(String text) onSubmitted;

  const InputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    const int maxLines = 5;
    final int minLines = math.min(1, maxLines); // ensures min <= max

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
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.heading3Regular,
          prefixIcon: const Icon(Icons.chat_bubble_outline_rounded,
              color: AppColors.neutralDarkGray),
          suffixIcon: IconButton(
            onPressed: () => controller.clear(),
            icon: const Icon(Icons.clear_rounded,
                color: AppColors.neutralDarkGray),
            tooltip: 'Clear',
          ),
          border: InputBorder.none,
          contentPadding: AppSpacing.paddingH12V12,
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }
}
