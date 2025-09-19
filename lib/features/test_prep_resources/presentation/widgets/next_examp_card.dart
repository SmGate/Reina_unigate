import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_reminder.dart';

import 'days_badge.dart';

class NextExamCard extends StatelessWidget {
  final Reminder? reminder;
  const NextExamCard({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);

    String title = 'No upcoming exam';
    String subtitle = 'Add one to get alerts.';
    int days = 0;

    if (reminder != null) {
      days =
          (reminder!.dateTime.difference(DateTime.now()).inDays).clamp(0, 9999);
      title = '${reminder!.test} in $days days';
      subtitle = 'On ${_fmt(reminder!.dateTime)}';
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: radius,
      ),
      child: Padding(
        padding: AppSpacing.paddingH12V12,
        child: Row(
          children: [
            DaysBadge(days: days),
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
                  Text(subtitle,
                      style: AppTextStyles.heading3Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }
}
