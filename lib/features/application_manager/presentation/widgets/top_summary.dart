import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class TopSummary extends StatelessWidget {
  final int applied;
  final int ongoing;
  final int completed;
  final VoidCallback onQuickChecklist;

  const TopSummary({
    super.key,
    required this.applied,
    required this.ongoing,
    required this.completed,
    required this.onQuickChecklist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        children: [
          // Chips: horizontally scrollable to avoid overflow
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _SummaryChip(label: 'Applied', value: applied.toString()),
                AppSpacing.width10,
                _SummaryChip(label: 'Ongoing', value: ongoing.toString()),
                AppSpacing.width10,
                _SummaryChip(label: 'Completed', value: completed.toString()),
              ],
            ),
          ),
          AppSpacing.height12,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  width: double.infinity,
                  text: 'Open Checklist',
                  onPressed: onQuickChecklist,
                ),
              ),
              AppSpacing.width10,
              Expanded(
                child: CustomButton(
                  width: double.infinity,
                  text: 'New Application',
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tap + to start applying')),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingH12V12,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.heading3Regular),
          AppSpacing.width8,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(value, style: AppTextStyles.inter400Black16),
          ),
        ],
      ),
    );
  }
}
