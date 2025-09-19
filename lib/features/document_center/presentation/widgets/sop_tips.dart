import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class SopTips extends StatelessWidget {
  final List<String> tips;
  const SopTips({super.key, required this.tips});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: AppSpacing.paddingH12V12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tips', style: AppTextStyles.displaySmall500),
            AppSpacing.height6,
            ...tips.map((t) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.lightbulb_rounded, size: 16, color: AppColors.royalBlue),
                      AppSpacing.width6,
                      Expanded(child: Text(t, style: AppTextStyles.heading3Light12)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
