import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_guid.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/search_field.dart';


class GuideCard extends StatelessWidget {
  final Guide guide;
  final VoidCallback onOpen;
  const GuideCard({super.key, required this.guide, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(guide.name,
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                AppSpacing.width8,
                MiniChip(guide.scoreScale),
              ],
            ),
            AppSpacing.height6,
            Row(
              children: [
                const Icon(Icons.schedule_rounded,
                    size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 4),
                Expanded(
                  child: Text('Duration: ${guide.duration}',
                      style: AppTextStyles.heading3Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            AppSpacing.height6,
            Row(
              children: [
                const Icon(Icons.view_agenda_rounded,
                    size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(guide.format,
                      style: AppTextStyles.heading3Regular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            AppSpacing.height10,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Open Guide',
                    onPressed: onOpen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
