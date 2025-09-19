import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class ProgressTile extends StatelessWidget {
  final String title;
  final double value; // 0..1
  final String caption;
  final Color barColor;

  const ProgressTile({
    super.key,
    required this.title,
    required this.value,
    required this.caption,
    required this.barColor,
  });

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Padding(
        padding: AppSpacing.paddingH12V12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.inter600Black16),
            AppSpacing.height8,
            LayoutBuilder(
              builder: (context, c) {
                return Stack(
                  children: [
                    Container(
                      height: 12,
                      width: c.maxWidth,
                      decoration: BoxDecoration(
                        color: AppColors.neutralVeryLight,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      height: 12,
                      width: c.maxWidth * v,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [barColor.withOpacity(.85), barColor],
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],
                );
              },
            ),
            AppSpacing.height6,
            Text(caption, style: AppTextStyles.heading3Light12),
          ],
        ),
      ),
    );
  }
}
