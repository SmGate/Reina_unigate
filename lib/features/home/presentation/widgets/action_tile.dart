import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class ActionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String ctaText;
  final VoidCallback? onTap;
  final bool highlight;

  ActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.ctaText,
    required this.onTap,
    this.highlight = false,
  });
}

class ActionTile extends StatelessWidget {
  final ActionItem item;
  const ActionTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return Container(
      decoration: BoxDecoration(
        color: item.highlight ? const Color(0xFFE8F0FE) : AppColors.white,
        borderRadius: radius,
        border: Border.all(
          color: item.highlight
              ? AppColors.royalBlue.withOpacity(.25)
              : Colors.transparent,
        ),
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
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: AppSpacing.paddingAll10,
              child: Icon(item.icon, color: AppColors.skyBlueDark, size: 20),
            ),
            AppSpacing.width12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppTextStyles.inter600Black16),
                  AppSpacing.height2,
                  Text(item.subtitle, style: AppTextStyles.heading3Light12),
                ],
              ),
            ),
            AppSpacing.width10,
            SizedBox(
              width: 96,
              child: CustomButton(
                width: double.infinity,
                text: item.ctaText,
                onPressed: item.onTap ?? () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
