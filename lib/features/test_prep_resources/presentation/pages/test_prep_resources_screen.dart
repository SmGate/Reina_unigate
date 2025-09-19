// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:flutter/material.dart';
// AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_center.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_guid.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_reminder.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/add_reminder_sheet.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/book_tab.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/guid_detail_sheet.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/guid_tab.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/reminder_tab.dart';

class TestPrepScreen extends StatefulWidget {
  const TestPrepScreen({super.key});

  @override
  State<TestPrepScreen> createState() => _TestPrepScreenState();
}

class _TestPrepScreenState extends State<TestPrepScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // ===== Mock data =====
  final List<Guide> _guides = [
    const Guide(
      name: 'IELTS Academic',
      duration: '2h 45m',
      format: 'Listening • Reading • Writing • Speaking',
      scoreScale: 'Band 0–9',
      tips: [
        'Practice listening with diverse accents.',
        'Time each Reading section strictly.',
        'Use task-1/2 structures in Writing.',
        'Record Speaking answers to review fluency.',
      ],
      links: [
        'Official band descriptors',
        'Sample tests',
        'British Council resources',
      ],
    ),
    const Guide(
      name: 'TOEFL iBT',
      duration: '3h',
      format: 'Reading • Listening • Speaking • Writing',
      scoreScale: '0–120',
      tips: [
        'Skim passages, then target question types.',
        'Note-taking is key in Listening.',
        'Template your Speaking responses (15 sec prep).',
        'Use integrated note keywords for Writing.',
      ],
      links: [
        'ETS practice tests',
        'Scoring rubrics',
        'Test day checklist',
      ],
    ),
  ];

  final List<TestCenter> _centers = [
    const TestCenter(
      provider: 'British Council',
      test: 'IELTS',
      region: 'USA, UK, Canada, EU, Asia',
      website: 'https://ielts.org',
    ),
    const TestCenter(
      provider: 'IDP',
      test: 'IELTS',
      region: 'UK, Australia, Asia, Middle East',
      website: 'https://www.ieltsidpindia.com',
    ),
    const TestCenter(
      provider: 'ETS',
      test: 'TOEFL',
      region: 'Worldwide',
      website: 'https://www.ets.org/toefl',
    ),
  ];

  final List<Reminder> _reminders = [
    Reminder(
        test: 'IELTS', dateTime: DateTime.now().add(const Duration(days: 35))),
    Reminder(
        test: 'TOEFL', dateTime: DateTime.now().add(const Duration(days: 62))),
  ];

  // Search controllers
  final _guideSearch = TextEditingController();
  final _centerSearch = TextEditingController();

  // Filters
  String _testFilter = 'All';
  final List<String> _testOptions = const ['All', 'IELTS', 'TOEFL'];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _guideSearch.dispose();
    _centerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text('Test Prep & Resources',
            style: AppTextStyles.displayMediumMedium20),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            color: AppColors.white,
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tab,
              indicatorColor: AppColors.royalBlue,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: [
                Tab(
                    child: Text('Guides',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('Book a Test',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('Reminders',
                        style: AppTextStyles.displayMediumMedium12)),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          GuidesTab(
            guides: _guides,
            searchCtrl: _guideSearch,
            onOpen: _openGuide,
          ),
          BookTab(
            centers: _centers,
            searchCtrl: _centerSearch,
            testFilter: _testFilter,
            testOptions: _testOptions,
            onFilterChanged: (v) => setState(() => _testFilter = v),
            onOpenCenter: _openCenter,
          ),
          RemindersTab(
            reminders: _reminders,
            onAdd: _addReminder,
            onDelete: (r) => setState(() => _reminders.remove(r)),
          ),
        ],
      ),
    );
  }

  // ===== Actions =====
  void _openGuide(Guide g) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => GuideDetailSheet(guide: g),
    );
  }

  void _openCenter(TestCenter c) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening: ${c.website}')),
    );
  }

  Future<void> _addReminder() async {
    final result = await showModalBottomSheet<Reminder>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddReminderSheet(),
    );
    if (result != null) {
      setState(() => _reminders.add(result));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reminder saved')),
      );
    }
  }
}
