import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/home/presentation/widgets/twin_ring_progress.dart';

class HeroSummary extends StatelessWidget {
  final double profileCompletion;
  final double applicationProgress;
  final VoidCallback onSmartPlan;

  const HeroSummary({
    super.key,
    required this.profileCompletion,
    required this.applicationProgress,
    required this.onSmartPlan,
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome back 👋', style: AppTextStyles.heading3White),
                    AppSpacing.height2,
                    Text(
                      'Here’s your progress snapshot and what to do next.',
                      style: AppTextStyles.heading3White,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              TwinRingProgress(
                profile: profileCompletion,
                applications: applicationProgress,
              ),
            ],
          ),
          AppSpacing.height12,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  width: double.infinity,
                  text: "Generate Smart Plan",
                  onPressed: onSmartPlan,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
