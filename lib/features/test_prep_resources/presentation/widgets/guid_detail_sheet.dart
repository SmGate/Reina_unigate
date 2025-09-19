import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_guid.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/search_field.dart';

class GuideDetailSheet extends StatelessWidget {
  final Guide guide;
  const GuideDetailSheet({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH16V12.add(
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(guide.name, style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height8,
            ChipRow(children: [
              MiniChip('Duration: ${guide.duration}'),
              MiniChip(guide.scoreScale),
            ]),
            AppSpacing.height10,
            Row(
              children: [
                const Icon(Icons.view_agenda_rounded,
                    size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 4),
                Expanded(
                  child: Text('Format: ${guide.format}',
                      style: AppTextStyles.heading3Regular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            AppSpacing.height12,
            Text('Tips', style: AppTextStyles.inter600Black16),
            AppSpacing.height6,
            ...guide.tips.map((t) => Bullet(t)).toList(),
            AppSpacing.height12,
            Text('Useful links', style: AppTextStyles.inter600Black16),
            AppSpacing.height6,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: guide.links
                  .map((l) => LinkPill(
                        label: l,
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Opening: $l'))),
                      ))
                  .toList(),
            ),
            AppSpacing.height6,
          ],
        ),
      ),
    );
  }
}
