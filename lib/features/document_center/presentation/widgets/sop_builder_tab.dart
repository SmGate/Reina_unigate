import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

import 'sop_field.dart';
import 'sop_tips.dart';

class SopBuilderTab extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController intro;
  final TextEditingController academic;
  final TextEditingController projects;
  final TextEditingController goals;
  final TextEditingController conclusion;

  final VoidCallback onPreview;
  final VoidCallback onExport;

  const SopBuilderTab({
    super.key,
    required this.title,
    required this.intro,
    required this.academic,
    required this.projects,
    required this.goals,
    required this.conclusion,
    required this.onPreview,
    required this.onExport,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Banner
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
              Text('SOP Builder', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Guided sections with best practices.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Preview',
                      onPressed: onPreview,
                    ),
                  ),
                  AppSpacing.width10,
                  Expanded(
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Export PDF',
                      onPressed: onExport,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Form sections
        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: [
              SopField(
                label: 'SOP Title',
                controller: title,
                maxLines: 1,
                hint: 'e.g., Statement of Purpose',
              ),
              AppSpacing.height8,
              SopField(
                label: 'Introduction',
                controller: intro,
                hint: 'Who you are, motivation, hook',
              ),
              const SopTips(tips: [
                'Open with a strong, concise hook.',
                'Connect your background with your intended field.',
              ]),
              AppSpacing.height8,
              SopField(
                label: 'Academic Background',
                controller: academic,
                hint: 'Key courses, grades, achievements',
              ),
              const SopTips(tips: [
                'Highlight 2–3 relevant courses/projects.',
                'Use specific numbers (GPA, ranks).',
              ]),
              AppSpacing.height8,
              SopField(
                label: 'Projects / Experience',
                controller: projects,
                hint: 'Projects, internships, impact',
              ),
              const SopTips(tips: [
                'Show outcomes and your role.',
                'Keep each example short and measurable.',
              ]),
              AppSpacing.height8,
              SopField(
                label: 'Goals & Program Fit',
                controller: goals,
                hint: 'Short/long-term goals, why this university',
              ),
              const SopTips(tips: [
                'Tie faculty/labs/courses to your goals.',
                'Avoid generic claims; be specific.',
              ]),
              AppSpacing.height8,
              SopField(
                label: 'Conclusion',
                controller: conclusion,
                hint: 'Wrap-up and future vision',
              ),
              AppSpacing.height12,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Preview',
                      onPressed: onPreview,
                    ),
                  ),
                  AppSpacing.width10,
                  Expanded(
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Save Draft',
                      onPressed: () =>
                          ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('SOP draft saved')),
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.height24,
            ],
          ),
        ),
      ],
    );
  }
}
