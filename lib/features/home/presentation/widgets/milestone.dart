import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class MilestoneStep {
  final String title;
  final bool done;
  const MilestoneStep(this.title, this.done);
}

class MilestoneCard extends StatelessWidget {
  final List<MilestoneStep> steps;
  const MilestoneCard({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: AppSpacing.paddingH12V12,
        child: Column(
          children: steps.map((s) => _MilestoneRow(step: s)).toList(),
        ),
      ),
    );
  }
}

class _MilestoneRow extends StatelessWidget {
  final MilestoneStep step;
  const _MilestoneRow({required this.step});

  @override
  Widget build(BuildContext context) {
    final isDone = step.done;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            color: isDone ? const Color(0xFF2E7D32) : AppColors.neutralDarkGray,
          ),
          AppSpacing.width10,
          Expanded(
            child: Text(
              step.title,
              style: isDone
                  ? AppTextStyles.heading3Light
                  : AppTextStyles.inter400Black16,
            ),
          ),
          if (!isDone)
            SizedBox(
              width: 96,
              child: CustomButton(
                width: double.infinity,
                text: "Start",
                onPressed: () {},
              ),
            ),
        ],
      ),
    );
  }
}
