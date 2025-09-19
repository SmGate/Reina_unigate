// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/features/home/presentation/widgets/action_tile.dart';
import 'package:unigate/features/home/presentation/widgets/hero_summary.dart';
import 'package:unigate/features/home/presentation/widgets/milestone.dart';
import 'package:unigate/features/home/presentation/widgets/progress_tile.dart';
import 'package:unigate/features/home/presentation/widgets/section_header.dart';
import 'package:unigate/features/home/presentation/widgets/stat_card.dart';
import 'package:unigate/features/home/presentation/widgets/tip_card.dart';

class StudentAnalyticsHome extends StatefulWidget {
  const StudentAnalyticsHome({super.key});

  @override
  State<StudentAnalyticsHome> createState() => _StudentAnalyticsHomeState();
}

class _StudentAnalyticsHomeState extends State<StudentAnalyticsHome> {
  // ---- Mock analytics (replace with API / bloc) ----
  double profileCompletion = 0.72; // 72%
  double applicationProgress = 0.58; // 58%
  final Map<String, int> apps = const {
    'applied': 8,
    'accepted': 2,
    'pending': 5,
    'rejected': 1,
  };

  final List<String> tips = const [
    'Upload your intermediate transcript.',
    'Shortlist at least 3 safety universities.',
    'Add IELTS/TOEFL score to unlock scholarships.',
    'Draft a focused Statement of Purpose.',
  ];

  final List<ActionItem> actions = [
    ActionItem(
      icon: Icons.description_rounded,
      title: 'Complete Profile',
      subtitle: 'Add CNIC, education, and contact details',
      ctaText: 'Update',
      onTap: null, // wire to route
      highlight: true,
    ),
    ActionItem(
      icon: Icons.upload_file_rounded,
      title: 'Upload Documents',
      subtitle: 'Transcript, passport, recommendation letter',
      ctaText: 'Upload',
      onTap: null,
    ),
    ActionItem(
      icon: Icons.school_rounded,
      title: 'Book Counseling',
      subtitle: 'Free 15-min advisor session',
      ctaText: 'Book',
      onTap: null,
    ),
  ];

  static const Color _primary = AppColors.royalBlue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ===== Top Hero Summary =====
          HeroSummary(
            profileCompletion: profileCompletion,
            applicationProgress: applicationProgress,
            onSmartPlan: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Generating your smart plan…')),
              );
            },
          ),

          AppSpacing.height10,

          // ===== Stats =====
          Padding(
            padding: AppSpacing.paddingH16,
            child: Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'Applied',
                    value: apps['applied']!.toString(),
                    icon: Icons.outbox_rounded,
                    bg: Colors.white,
                    fgIcon: AppColors.skyBlueDark,
                  ),
                ),
                AppSpacing.width10,
                Expanded(
                  child: StatCard(
                    label: 'Accepted',
                    value: apps['accepted']!.toString(),
                    icon: Icons.verified_rounded,
                    bg: const Color(0xFFEFF7EE),
                    fgIcon: const Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.height10,
          Padding(
            padding: AppSpacing.paddingH16,
            child: Row(
              children: [
                Expanded(
                  child: StatCard(
                    label: 'Pending',
                    value: apps['pending']!.toString(),
                    icon: Icons.hourglass_bottom_rounded,
                    bg: const Color(0xFFFFF7E8),
                    fgIcon: const Color(0xFFB26A00),
                  ),
                ),
                AppSpacing.width10,
                Expanded(
                  child: StatCard(
                    label: 'Rejected',
                    value: apps['rejected']!.toString(),
                    icon: Icons.cancel_rounded,
                    bg: const Color(0xFFFFEBEE),
                    fgIcon: const Color(0xFFC62828),
                  ),
                ),
              ],
            ),
          ),

          // ===== Progress Overview =====
          SectionHeader(
            title: 'Progress Overview',
            actionText: 'View Details',
            onAction: () {}, // optional route
          ),
          Padding(
            padding: AppSpacing.paddingH16,
            child: Column(
              children: [
                ProgressTile(
                  title: 'Profile completion',
                  value: profileCompletion,
                  barColor: _primary,
                  caption: '${(profileCompletion * 100).round()}% complete',
                ),
                AppSpacing.height10,
                ProgressTile(
                  title: 'Applications progress',
                  value: applicationProgress,
                  barColor: AppColors.skyBlueDark,
                  caption: '${(applicationProgress * 100).round()}% done',
                ),
              ],
            ),
          ),

          // ===== Milestones =====
          SectionHeader(
            title: 'Next Milestones',
            actionText: 'All',
            onAction: () {},
          ),
          const Padding(
            padding: AppSpacing.paddingH16,
            child: MilestoneCard(
              steps: [
                MilestoneStep('Shortlist 5–8 universities', true),
                MilestoneStep('Upload academic documents', true),
                MilestoneStep('Take IELTS/TOEFL test', false),
                MilestoneStep('Submit 3 applications', false),
                MilestoneStep('Apply for scholarships', false),
              ],
            ),
          ),

          // ===== Personalized Tips =====
          SectionHeader(
            title: 'Personalized Tips',
            actionText: 'Refresh',
            onAction: () {},
          ),
          SizedBox(
            height: 140,
            child: ListView.separated(
              padding: AppSpacing.paddingH16,
              scrollDirection: Axis.horizontal,
              itemCount: tips.length,
              separatorBuilder: (_, __) => AppSpacing.width12,
              itemBuilder: (_, i) => TipCard(text: tips[i]),
            ),
          ),

          // ===== Next Actions =====
          SectionHeader(
            title: 'Next Actions',
            actionText: 'Manage',
            onAction: () {},
          ),
          Padding(
            padding: AppSpacing.paddingH16,
            child: Column(
              children: actions
                  .map((a) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ActionTile(item: a),
                      ))
                  .toList(),
            ),
          ),

          AppSpacing.height24,
        ],
      ),
    );
  }
}
