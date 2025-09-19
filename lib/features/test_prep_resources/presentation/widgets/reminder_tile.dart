import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_reminder.dart';

import 'days_badge.dart';

class ReminderTile extends StatelessWidget {
  final Reminder reminder;
  final VoidCallback onDelete;
  const ReminderTile(
      {super.key, required this.reminder, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    final days =
        math.max(0, reminder.dateTime.difference(DateTime.now()).inDays);

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
            DaysBadge(days: days),
            AppSpacing.width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${reminder.test} — ${_fmt(reminder.dateTime)}',
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  AppSpacing.height2,
                  Text(
                    days == 0 ? 'Today' : '$days days remaining',
                    style: AppTextStyles.heading3Regular,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            AppSpacing.width10,
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 96, maxWidth: 120),
              child: CustomButton(
                width: double.infinity,
                text: 'Delete',
                onPressed: onDelete,
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
