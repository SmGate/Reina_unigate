import 'package:flutter/material.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class DaysBadge extends StatelessWidget {
  final int days;
  const DaysBadge({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    final v = (days == 0) ? 1.0 : (1.0 - (days / 90.0)).clamp(0.0, 1.0);
    return SizedBox(
      height: 48,
      width: 48,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 48,
            width: 48,
            child: CircularProgressIndicator(
              value: v,
              strokeWidth: 6,
              backgroundColor: AppColors.neutralVeryLight,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.royalBlue),
            ),
          ),
          Text(
            days == 0 ? '—' : 'D$days',
            style: AppTextStyles.displayMediumMedium12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
