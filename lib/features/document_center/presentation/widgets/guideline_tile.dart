import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class GuidelineTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const GuidelineTile(
      {super.key, required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: AppSpacing.paddingH12V12,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              padding: AppSpacing.paddingAll10,
              child: Icon(icon, color: AppColors.skyBlueDark, size: 20),
            ),
            AppSpacing.width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  AppSpacing.height2,
                  Text(body, style: AppTextStyles.heading3Light12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
