import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_center.dart';


class CenterTile extends StatelessWidget {
  final TestCenter center;
  final VoidCallback onOpen;
  const CenterTile({super.key, required this.center, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    final isIelts = center.test.toLowerCase() == 'ielts';

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
        child: Row(
          children: [
            Container(
              padding: AppSpacing.paddingAll10,
              decoration: BoxDecoration(
                color: isIelts ? const Color(0xFFEAF4FF) : const Color(0xFFFFF3E0),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isIelts ? Icons.language_rounded : Icons.public_rounded,
                color: isIelts ? AppColors.skyBlueDark : const Color(0xFFB26A00),
                size: 22,
              ),
            ),
            AppSpacing.width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${center.provider} • ${center.test}',
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  AppSpacing.height2,
                  Row(
                    children: [
                      const Icon(Icons.place_rounded,
                          size: 16, color: AppColors.neutralDarkGray),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(center.region,
                            style: AppTextStyles.heading3Light12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  AppSpacing.height2,
                  Row(
                    children: [
                      const Icon(Icons.link_rounded,
                          size: 16, color: AppColors.neutralDarkGray),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(center.website,
                            style: AppTextStyles.heading3Regular,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.width10,
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 96, maxWidth: 120),
              child: CustomButton(
                width: double.infinity,
                text: 'Open',
                onPressed: onOpen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
