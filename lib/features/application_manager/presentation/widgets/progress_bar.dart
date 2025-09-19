import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class ProgressBar extends StatelessWidget {
  final String label;
  final double value;
  const ProgressBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: AppTextStyles.displayMediumMedium12),
            const Spacer(),
            Text('${(v * 100).round()}%',
                style: AppTextStyles.displayMediumMedium12),
          ],
        ),
        AppSpacing.height6,
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
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.skyBlueMid, AppColors.royalBlue],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(999)),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
