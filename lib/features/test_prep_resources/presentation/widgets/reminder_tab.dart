import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_reminder.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/next_examp_card.dart';

import '../widgets/reminder_tile.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class RemindersTab extends StatelessWidget {
  final List<Reminder> reminders;
  final VoidCallback onAdd;
  final void Function(Reminder) onDelete;

  const RemindersTab({
    super.key,
    required this.reminders,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final next = reminders.isEmpty
        ? null
        : reminders.reduce((a, b) => a.dateTime.isBefore(b.dateTime) ? a : b);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding: AppSpacing.paddingH16V12,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.skyBlueMid, AppColors.royalBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Test Reminder', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Alerts & timelines for exam dates.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              Row(
                children: [
                  Expanded(child: NextExamCard(reminder: next)),
                  AppSpacing.width10,
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 120, maxWidth: 160),
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Add Reminder',
                      onPressed: onAdd,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.height12,
        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: reminders.map((r) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ReminderTile(reminder: r, onDelete: () => onDelete(r)),
              );
            }).toList(),
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }
}
