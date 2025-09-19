import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class SopPreviewBlock extends StatelessWidget {
  final String label;
  final String text;
  const SopPreviewBlock({super.key, required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    if (text.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: AppSpacing.paddingH12V12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.displaySmall500),
              AppSpacing.height6,
              Text(text, style: AppTextStyles.inter400Black16),
            ],
          ),
        ),
      ),
    );
  }
}
