import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

import 'guideline_tile.dart';

class ExpertReviewTab extends StatelessWidget {
  final VoidCallback onSubmit;
  const ExpertReviewTab({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Header
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
              Text('Expert Review', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Get feedback from our advisors.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              CustomButton(
                width: double.infinity,
                text: 'Submit for Review',
                onPressed: onSubmit,
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Guidelines
        const Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: [
              GuidelineTile(
                icon: Icons.checklist_rounded,
                title: 'Checklist',
                body:
                    'Ensure core docs are uploaded: transcript, passport, resume, SOP.',
              ),
              SizedBox(height: 8),
              GuidelineTile(
                icon: Icons.rule_folder_rounded,
                title: 'Formatting',
                body:
                    'Use PDF for documents. Keep filenames clear and consistent.',
              ),
              SizedBox(height: 8),
              GuidelineTile(
                icon: Icons.timelapse_rounded,
                title: 'Turnaround',
                body:
                    'Typical feedback window: 2–3 business days after submission.',
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }
}
