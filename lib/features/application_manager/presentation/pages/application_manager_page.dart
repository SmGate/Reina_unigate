// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/application_manager/data/model/application_models.dart';
import 'package:unigate/features/application_manager/presentation/widgets/application_card.dart';
import 'package:unigate/features/application_manager/presentation/widgets/apply_row.dart';
import 'package:unigate/features/application_manager/presentation/widgets/checklist_sheet.dart';
import 'package:unigate/features/application_manager/presentation/widgets/filter_chip_pill.dart';
import 'package:unigate/features/application_manager/presentation/widgets/search_field.dart';
import 'package:unigate/features/application_manager/presentation/widgets/top_summary.dart';

class ApplicationManagerScreen extends StatefulWidget {
  const ApplicationManagerScreen({super.key});

  @override
  State<ApplicationManagerScreen> createState() =>
      _ApplicationManagerScreenState();
}

class _ApplicationManagerScreenState extends State<ApplicationManagerScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;
  String _query = '';
  final Set<String> _activeFilters = {};

  // ---- Mock data (replace with API/Bloc) ----
  final List<ApplicationItem> _ongoing = [
    ApplicationItem(
      university: 'University of Toronto',
      country: 'Canada',
      program: 'BSc Computer Science',
      deadline: 'Oct 12, 2025',
      status: AppStatus.inReview,
      progress: 0.62,
      tasks: [
        Task('Transcript upload', true),
        Task('SOP draft', true),
        Task('Recommendation letters (2)', false),
        Task('Application fee payment', false),
      ],
      banner:
          'https://images.unsplash.com/photo-1503674888379-4a8a1f3f1e59?q=80&w=1200&auto=format&fit=crop',
    ),
    ApplicationItem(
      university: 'ETH Zürich',
      country: 'Switzerland',
      program: 'BS Data Science',
      deadline: 'Sep 28, 2025',
      status: AppStatus.awaitingDocs,
      progress: 0.38,
      tasks: [
        Task('Passport copy', true),
        Task('Bank statement', false),
        Task('IELTS score', false),
      ],
      banner:
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?q=80&w=1200&auto=format&fit=crop',
    ),
    ApplicationItem(
      university: 'National University of Singapore',
      country: 'Singapore',
      program: 'BEng Software Engineering',
      deadline: 'Nov 05, 2025',
      status: AppStatus.draft,
      progress: 0.18,
      tasks: [
        Task('Profile info', true),
        Task('SOP outline', false),
        Task('Academic CV', false),
      ],
      banner:
          'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=1200&auto=format&fit=crop',
    ),
  ];

  final List<ApplicationItem> _completed = [
    ApplicationItem(
      university: 'Imperial College London',
      country: 'UK',
      program: 'BSc Computing',
      deadline: 'Closed',
      status: AppStatus.accepted,
      progress: 1.0,
      tasks: [Task('All steps done', true)],
      banner:
          'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1200&auto=format&fit=crop',
    ),
    ApplicationItem(
      university: 'MIT',
      country: 'USA',
      program: 'BS Computer Science',
      deadline: 'Closed',
      status: AppStatus.rejected,
      progress: 1.0,
      tasks: [Task('All steps done', true)],
      banner:
          'https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?q=80&w=1200&auto=format&fit=crop',
    ),
  ];

  final List<String> _filters = const [
    'Country',
    'Program',
    'Deadline',
    'Status'
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final completed = _completed.length;
    final ongoing = _ongoing.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),

      // Header with Tabs + (+) button lives inside body
      body: Column(
        children: [
          // Sticky tabs header
          Container(
            color: AppColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SafeArea(
              bottom: false,
              top: false,
              child: SizedBox(
                height: 46,
                child: Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        controller: _tab,
                        indicatorColor: AppColors.royalBlue,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        tabs: [
                          Tab(
                            child: Text('Ongoing ($ongoing)',
                                style: AppTextStyles.displayMediumMedium12),
                          ),
                          Tab(
                            child: Text('Completed ($completed)',
                                style: AppTextStyles.displayMediumMedium12),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline_rounded,
                          color: AppColors.blackish),
                      tooltip: 'Apply to a university',
                      onPressed: _openApplySheet,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Expanded(
            child: TabBarView(
              controller: _tab,
              children: [
                _buildTabBody(context, items: _filtered(_ongoing)),
                _buildTabBody(context,
                    items: _filtered(_completed), isCompleted: true),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openApplySheet,
        backgroundColor: AppColors.royalBlue,
        icon: const Icon(Icons.school_rounded, color: Colors.white),
        label: const Text(
          'Apply',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // ============== TAB BODY ==============
  Widget _buildTabBody(BuildContext context,
      {required List<ApplicationItem> items, bool isCompleted = false}) {
    final applied = _ongoing.length + _completed.length;
    final ongoing = _ongoing.length;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        TopSummary(
          applied: applied,
          ongoing: ongoing,
          completed: _completed.length,
          onQuickChecklist: () {
            if (items.isNotEmpty) _openChecklist(items.first);
          },
        ),

        // Search
        Padding(
          padding: AppSpacing.paddingH16,
          child: SearchField(onChanged: (v) => setState(() => _query = v)),
        ),

        AppSpacing.height8,

        // Filters
        SizedBox(
          height: 48,
          child: ListView.separated(
            padding: AppSpacing.paddingH16,
            scrollDirection: Axis.horizontal,
            itemCount: _filters.length,
            separatorBuilder: (_, __) => AppSpacing.width8,
            itemBuilder: (_, i) {
              final l = _filters[i];
              final selected = _activeFilters.contains(l);
              return FilterChipPill(
                label: l,
                selected: selected,
                onTap: () {
                  setState(() {
                    selected ? _activeFilters.remove(l) : _activeFilters.add(l);
                  });
                },
              );
            },
          ),
        ),

        AppSpacing.height8,

        // List of applications
        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: items.map((e) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ApplicationCard(
                  item: e,
                  isCompleted: isCompleted,
                  onChecklist: () => _openChecklist(e),
                ),
              );
            }).toList(),
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }

  List<ApplicationItem> _filtered(List<ApplicationItem> list) {
    if (_query.trim().isEmpty && _activeFilters.isEmpty) return list;
    final q = _query.toLowerCase();
    return list.where((e) {
      final hit = e.university.toLowerCase().contains(q) ||
          e.country.toLowerCase().contains(q) ||
          e.program.toLowerCase().contains(q);
      if (_activeFilters.isEmpty) return hit;
      final tags = {
        'Country': e.country,
        'Program': e.program,
        'Status': e.status.label,
        'Deadline': e.deadline,
      };
      final hasAll = _activeFilters.every((f) => (tags[f] ?? '').isNotEmpty);
      return hit && hasAll;
    }).toList();
  }

  // ============== ACTIONS ==============
  void _openChecklist(ApplicationItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ChecklistSheet(
        item: item,
        onUpdate: () => setState(() {}),
      ),
    );
  }

  void _openApplySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: AppSpacing.paddingH16V12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text('Quick Apply', style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height12,
            const ApplyRow(
                label: 'University', hint: 'e.g., University of Oxford'),
            AppSpacing.height8,
            const ApplyRow(
                label: 'Program', hint: 'e.g., BSc Computer Science'),
            AppSpacing.height8,
            const ApplyRow(label: 'Country', hint: 'e.g., UK'),
            AppSpacing.height12,
            CustomButton(
              width: double.infinity,
              text: 'Start Application',
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Application draft created')),
                );
              },
            ),
            AppSpacing.height8,
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: AppTextStyles.displaySmall500),
            ),
            AppSpacing.height6,
          ],
        ),
      ),
    );
  }
}
