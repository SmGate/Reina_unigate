import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/application_manager/data/model/application_models.dart';
import 'package:unigate/features/application_manager/presentation/widgets/progress_bar.dart';
import 'package:unigate/features/application_manager/presentation/widgets/status_pill.dart';

class ApplicationCard extends StatelessWidget {
  final ApplicationItem item;
  final bool isCompleted;
  final VoidCallback onChecklist;

  const ApplicationCard({
    super.key,
    required this.item,
    required this.isCompleted,
    required this.onChecklist,
  });

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
      child: ClipRRect(
        borderRadius: radius,
        child: Column(
          children: [
            // Banner
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    item.banner,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.neutralVeryLight,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported_outlined),
                    ),
                    loadingBuilder: (c, w, p) {
                      if (p == null) return w;
                      return Container(
                        color: AppColors.neutralVeryLight,
                        alignment: Alignment.center,
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.05),
                          Colors.black.withOpacity(.35)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: StatusPill(status: item.status),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: AppSpacing.paddingH12V12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.university,
                          style: AppTextStyles.inter600Black16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSpacing.width8,
                      const Icon(Icons.place_rounded,
                          size: 16, color: AppColors.neutralDarkGray),
                      AppSpacing.width4,
                      Text(item.country, style: AppTextStyles.heading3Light12),
                    ],
                  ),
                  AppSpacing.height2,
                  Text(item.program,
                      style: AppTextStyles.inter400Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),

                  AppSpacing.height10,

                  // Progress
                  ProgressBar(label: 'Progress', value: item.progress),

                  AppSpacing.height8,

                  // Deadline + buttons
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.event_rounded,
                              size: 16, color: AppColors.neutralDarkGray),
                          AppSpacing.width4,
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 220),
                            child: Text(
                              'Deadline: ${item.deadline}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.heading3Light12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 120,
                        child: CustomButton(
                          width: double.infinity,
                          text: 'Checklist',
                          onPressed: onChecklist,
                        ),
                      ),
                      if (!isCompleted)
                        SizedBox(
                          width: 120,
                          child: CustomButton(
                            width: double.infinity,
                            text: 'Continue',
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Continuing ${item.university}'),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
