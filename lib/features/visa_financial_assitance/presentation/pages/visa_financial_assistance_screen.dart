// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'dart:math' as math;

class VisaFinanceScreen extends StatefulWidget {
  const VisaFinanceScreen({super.key});

  @override
  State<VisaFinanceScreen> createState() => _VisaFinanceScreenState();
}

class _VisaFinanceScreenState extends State<VisaFinanceScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // ===== Mock Data =====
  final List<_VisaCountry> _countries = [
    _VisaCountry(
      name: 'United States',
      emoji: '🇺🇸',
      code: 'USA',
      steps: [
        _VisaStep('Get I-20 from university', true),
        _VisaStep('Pay SEVIS fee', false),
        _VisaStep('Fill DS-160', false),
        _VisaStep('Book biometrics (VAC)', false),
        _VisaStep('Attend interview', false),
        _VisaStep('Receive passport/visa', false),
      ],
    ),
    _VisaCountry(
      name: 'United Kingdom',
      emoji: '🇬🇧',
      code: 'UK',
      steps: [
        _VisaStep('CAS from university', true),
        _VisaStep('TB test (if required)', true),
        _VisaStep('Online application & NHS surcharge', false),
        _VisaStep('Biometrics appointment', false),
        _VisaStep('Collect BRP on arrival', false),
      ],
    ),
    _VisaCountry(
      name: 'Canada',
      emoji: '🇨🇦',
      code: 'CA',
      steps: [
        _VisaStep('Offer letter & tuition deposit', true),
        _VisaStep('Create GCKey account', false),
        _VisaStep('Upfront medical (optional)', false),
        _VisaStep('Submit SDS/Non-SDS file', false),
        _VisaStep('Biometrics invitation', false),
        _VisaStep('Passport request (PPR)', false),
      ],
    ),
    _VisaCountry(
      name: 'Australia',
      emoji: '🇦🇺',
      code: 'AU',
      steps: [
        _VisaStep('CoE from university', true),
        _VisaStep('Create ImmiAccount', false),
        _VisaStep('GTE statement', false),
        _VisaStep('Health check & biometrics', false),
        _VisaStep('Visa outcome', false),
      ],
    ),
    _VisaCountry(
      name: 'Germany',
      emoji: '🇩🇪',
      code: 'DE',
      steps: [
        _VisaStep('Admission letter', true),
        _VisaStep('Blocked account setup', false),
        _VisaStep('Health insurance', false),
        _VisaStep('Visa appointment & docs', false),
        _VisaStep('Residence permit on arrival', false),
      ],
    ),
  ];

  final List<_ScholarshipItem> _scholarships = [
    _ScholarshipItem(
      title: 'Global Merit Scholarship',
      country: 'USA',
      level: 'Undergrad',
      field: 'Computer Science',
      amount: '\$10,000',
      deadline: 'Nov 30, 2025',
      type: _ScholarType.merit,
    ),
    _ScholarshipItem(
      title: 'Commonwealth Shared Scholarship',
      country: 'UK',
      level: 'Masters',
      field: 'Engineering',
      amount: 'Full tuition + stipend',
      deadline: 'Dec 15, 2025',
      type: _ScholarType.need,
    ),
    _ScholarshipItem(
      title: 'Ontario Graduate Scholarship',
      country: 'Canada',
      level: 'Masters',
      field: 'Data Science',
      amount: 'CAD 15,000',
      deadline: 'Oct 20, 2025',
      type: _ScholarType.merit,
    ),
    _ScholarshipItem(
      title: 'DAAD Dev-Related Postgrad',
      country: 'Germany',
      level: 'Masters',
      field: 'Sustainability',
      amount: '€934/month + benefits',
      deadline: 'Sep 30, 2025',
      type: _ScholarType.need,
    ),
    _ScholarshipItem(
      title: 'Destination Australia',
      country: 'Australia',
      level: 'Undergrad',
      field: 'Any',
      amount: 'AUD 15,000/yr',
      deadline: 'Jan 10, 2026',
      type: _ScholarType.merit,
    ),
  ];

  // Loan calculator controllers
  final _tuitionCtrl = TextEditingController(text: '30000');
  final _downCtrl = TextEditingController(text: '5000');
  final _rateCtrl = TextEditingController(text: '7.5'); // annual %
  final _termCtrl = TextEditingController(text: '5'); // years

  // Scholarship search
  final _scholarSearchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _tuitionCtrl.dispose();
    _downCtrl.dispose();
    _rateCtrl.dispose();
    _termCtrl.dispose();
    _scholarSearchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title: Text('Visa & Financial Assistance',
            style: AppTextStyles.displayMediumMedium20),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(46),
          child: Container(
            alignment: Alignment.centerLeft,
            color: AppColors.white,
            child: TabBar(
              controller: _tab,
              indicatorColor: AppColors.royalBlue,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabs: [
                Tab(
                    child: Text('Visa',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('Scholarships',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('Loans & Forex',
                        style: AppTextStyles.displayMediumMedium12)),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _VisaTab(
            countries: _countries,
            onOpenChecklist: _openVisaChecklist,
          ),
          _ScholarshipsTab(
            all: _scholarships,
            searchCtrl: _scholarSearchCtrl,
            onOpen: _openScholarDetails,
          ),
          _LoansForexTab(
            tuitionCtrl: _tuitionCtrl,
            downCtrl: _downCtrl,
            rateCtrl: _rateCtrl,
            termCtrl: _termCtrl,
          ),
        ],
      ),
    );
  }

  // ===== Actions =====

  void _openVisaChecklist(_VisaCountry c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _VisaChecklistSheet(country: c),
    );
  }

  void _openScholarDetails(_ScholarshipItem s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: AppSpacing.paddingH16V12.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(s.title, style: AppTextStyles.displayMediumMedium18),
              AppSpacing.height8,
              _ChipRow(children: [
                _MiniChip('${s.country} • ${s.level}'),
                _MiniChip(s.field),
                _MiniChip(s.type == _ScholarType.need ? 'Need-based' : 'Merit'),
              ]),
              AppSpacing.height10,
              Row(
                children: [
                  const Icon(Icons.payments_rounded,
                      size: 16, color: AppColors.neutralDarkGray),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text('Award: ${s.amount}',
                        style: AppTextStyles.heading3Regular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.event_rounded,
                      size: 16, color: AppColors.neutralDarkGray),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text('Deadline: ${s.deadline}',
                        style: AppTextStyles.heading3Regular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              AppSpacing.height12,
              Text(
                'Eligibility & details:\n• Strong academics\n• Relevant field background\n• Motivation statement (SOP)\n• Refer official page for exact requirements.',
                style: AppTextStyles.inter400Black16,
              ),
              AppSpacing.height12,
              CustomButton(
                width: double.infinity,
                text: 'Apply / Learn More',
                onPressed: () => Navigator.pop(context),
              ),
              AppSpacing.height6,
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close', style: AppTextStyles.displaySmall500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===================== MODELS =====================

class _VisaCountry {
  final String name;
  final String emoji;
  final String code;
  final List<_VisaStep> steps;

  _VisaCountry({
    required this.name,
    required this.emoji,
    required this.code,
    required this.steps,
  });

  double get progress {
    if (steps.isEmpty) return 0;
    final done = steps.where((s) => s.done).length;
    return done / steps.length;
  }
}

class _VisaStep {
  final String title;
  bool done;
  _VisaStep(this.title, this.done);
}

enum _ScholarType { need, merit }

class _ScholarshipItem {
  final String title;
  final String country;
  final String level;
  final String field;
  final String amount;
  final String deadline;
  final _ScholarType type;

  _ScholarshipItem({
    required this.title,
    required this.country,
    required this.level,
    required this.field,
    required this.amount,
    required this.deadline,
    required this.type,
  });
}

// ===================== VISA TAB =====================

class _VisaTab extends StatefulWidget {
  final List<_VisaCountry> countries;
  final void Function(_VisaCountry) onOpenChecklist;

  const _VisaTab({
    required this.countries,
    required this.onOpenChecklist,
  });

  @override
  State<_VisaTab> createState() => _VisaTabState();
}

class _VisaTabState extends State<_VisaTab> {
  final _searchCtrl = TextEditingController();
  String _q = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = widget.countries
        .where((c) =>
            _q.trim().isEmpty ||
            c.name.toLowerCase().contains(_q.toLowerCase()) ||
            c.code.toLowerCase().contains(_q.toLowerCase()))
        .toList();

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
              Text('Visa Requirements', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Country-wise checklists & progress.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              _SearchField(
                controller: _searchCtrl,
                hint: 'Search country…',
                onChanged: (v) => setState(() => _q = v),
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Country grid
        Padding(
          padding: AppSpacing.paddingH16,
          child: LayoutBuilder(
            builder: (context, c) {
              int cols = 1;
              double cardHeight = 164;
              if (c.maxWidth >= 820) {
                cols = 3;
                cardHeight = 164;
              } else if (c.maxWidth >= 520) {
                cols = 2;
                cardHeight = 164;
              } else {
                cols = 1;
                cardHeight = 164;
              }
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: filtered.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: cardHeight, // fixed height -> no overflow
                ),
                itemBuilder: (_, i) => _VisaCard(
                  country: filtered[i],
                  onOpen: () => widget.onOpenChecklist(filtered[i]),
                ),
              );
            },
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }
}

class _VisaCard extends StatelessWidget {
  final _VisaCountry country;
  final VoidCallback onOpen;
  const _VisaCard({required this.country, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    final pct = (country.progress * 100).round();

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
            Container(
              height: 44,
              width: 44,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Text(country.emoji,
                  style: AppTextStyles.displayMediumMedium20),
            ),
            AppSpacing.width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(country.name,
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  AppSpacing.height2,
                  Text('$pct% complete', style: AppTextStyles.heading3Light12),
                  AppSpacing.height6,
                  _LinearProgress(value: country.progress),
                ],
              ),
            ),
            AppSpacing.width10,
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 96, maxWidth: 120),
              child: CustomButton(
                width: double.infinity,
                text: 'Checklist',
                onPressed: onOpen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinearProgress extends StatelessWidget {
  final double value;
  const _LinearProgress({required this.value});

  @override
  Widget build(BuildContext context) {
    final v = value.clamp(0.0, 1.0);
    return LayoutBuilder(builder: (context, c) {
      return Stack(
        children: [
          Container(
            width: c.maxWidth,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.neutralVeryLight,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            width: c.maxWidth * v,
            height: 10,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.skyBlueMid, AppColors.royalBlue],
              ),
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ],
      );
    });
  }
}

class _VisaChecklistSheet extends StatefulWidget {
  final _VisaCountry country;
  const _VisaChecklistSheet({required this.country});

  @override
  State<_VisaChecklistSheet> createState() => _VisaChecklistSheetState();
}

class _VisaChecklistSheetState extends State<_VisaChecklistSheet> {
  late final List<_VisaStep> _steps;

  @override
  void initState() {
    super.initState();
    _steps =
        widget.country.steps.map((s) => _VisaStep(s.title, s.done)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH16V12.add(
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
      ),
      child: SingleChildScrollView(
        child: Column(
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
            Text('${widget.country.emoji} ${widget.country.name}',
                style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height8,
            Text('Step-by-step checklist',
                style: AppTextStyles.heading3Regular),
            AppSpacing.height12,
            ...List.generate(_steps.length, (i) {
              final s = _steps[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    Checkbox(
                      value: s.done,
                      onChanged: (v) => setState(() => s.done = v ?? false),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child:
                          Text(s.title, style: AppTextStyles.inter400Black16),
                    ),
                  ],
                ),
              );
            }),
            AppSpacing.height12,
            CustomButton(
              width: double.infinity,
              text: 'Save Progress',
              onPressed: () {
                for (int i = 0; i < widget.country.steps.length; i++) {
                  widget.country.steps[i].done = _steps[i].done;
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Visa checklist updated')),
                );
              },
            ),
            AppSpacing.height6,
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: AppTextStyles.displaySmall500),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================== SCHOLARSHIPS TAB =====================

class _ScholarshipsTab extends StatefulWidget {
  final List<_ScholarshipItem> all;
  final TextEditingController searchCtrl;
  final void Function(_ScholarshipItem) onOpen;

  const _ScholarshipsTab({
    required this.all,
    required this.searchCtrl,
    required this.onOpen,
  });

  @override
  State<_ScholarshipsTab> createState() => _ScholarshipsTabState();
}

class _ScholarshipsTabState extends State<_ScholarshipsTab> {
  String _q = '';
  String _level = 'All';
  String _type = 'All';

  final _levels = const ['All', 'Undergrad', 'Masters', 'PhD'];
  final _types = const ['All', 'Need-based', 'Merit'];

  @override
  Widget build(BuildContext context) {
    final results = widget.all.where((s) {
      final hit = _q.trim().isEmpty ||
          s.title.toLowerCase().contains(_q.toLowerCase()) ||
          s.country.toLowerCase().contains(_q.toLowerCase()) ||
          s.field.toLowerCase().contains(_q.toLowerCase());
      final levelOk = _level == 'All' || s.level == _level;
      final typeOk = _type == 'All' ||
          (_type == 'Need-based' && s.type == _ScholarType.need) ||
          (_type == 'Merit' && s.type == _ScholarType.merit);
      return hit && levelOk && typeOk;
    }).toList();

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
              Text('Scholarship Finder', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Discover funding you’re eligible for.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              _SearchField(
                controller: widget.searchCtrl,
                hint: 'Search by title, field, or country…',
                onChanged: (v) => setState(() => _q = v),
              ),
              AppSpacing.height10,
              // Filters
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _DropdownPill(
                    label: 'Level',
                    value: _level,
                    items: _levels,
                    onChanged: (v) => setState(() => _level = v),
                  ),
                  _DropdownPill(
                    label: 'Type',
                    value: _type,
                    items: _types,
                    onChanged: (v) => setState(() => _type = v),
                  ),
                ],
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Results grid (NO OVERFLOWS)
        Padding(
          padding: AppSpacing.paddingH16,
          child: LayoutBuilder(
            builder: (context, c) {
              // Columns & fixed height per card: taller == safer for content
              int cols;
              double cardHeight;
              if (c.maxWidth >= 900) {
                cols = 3;
                cardHeight = 220;
              } else if (c.maxWidth >= 600) {
                cols = 2;
                cardHeight = 240;
              } else {
                cols = 1;
                cardHeight = 260;
              }

              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: results.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: cardHeight, // <— key fix
                ),
                itemBuilder: (_, i) => _ScholarCard(
                  item: results[i],
                  onOpen: () => widget.onOpen(results[i]),
                ),
              );
            },
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }
}

class _ScholarCard extends StatelessWidget {
  final _ScholarshipItem item;
  final VoidCallback onOpen;
  const _ScholarCard({required this.item, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + country chip
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: AppTextStyles.inter600Black16,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                AppSpacing.width8,
                _MiniChip(item.country),
              ],
            ),
            AppSpacing.height6,

            // Tag chips (wrap if needed)
            _ChipRow(children: [
              _MiniChip(item.level),
              _MiniChip(item.field),
              _MiniChip(
                  item.type == _ScholarType.need ? 'Need-based' : 'Merit'),
            ]),
            AppSpacing.height8,

            // Amount
            Row(
              children: [
                const Icon(Icons.payments_rounded,
                    size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Amount: ${item.amount}',
                    style: AppTextStyles.heading3Regular,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            AppSpacing.height4,

            // Deadline
            Row(
              children: [
                const Icon(Icons.event_rounded,
                    size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Deadline: ${item.deadline}',
                    style: AppTextStyles.heading3Regular,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Spacer removed to avoid forced expansion
            AppSpacing.height10,

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Details',
                    onPressed: onOpen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  final List<Widget> children;
  const _ChipRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: children,
    );
  }
}

class _MiniChip extends StatelessWidget {
  final String text;
  const _MiniChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: AppTextStyles.displaySmall500),
    );
  }
}

class _DropdownPill extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const _DropdownPill({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.neutralLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: AppTextStyles.inter400Black16),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

// ===================== LOANS & FOREX TAB =====================

class _LoansForexTab extends StatefulWidget {
  final TextEditingController tuitionCtrl;
  final TextEditingController downCtrl;
  final TextEditingController rateCtrl;
  final TextEditingController termCtrl;

  const _LoansForexTab({
    required this.tuitionCtrl,
    required this.downCtrl,
    required this.rateCtrl,
    required this.termCtrl,
  });

  @override
  State<_LoansForexTab> createState() => _LoansForexTabState();
}

class _LoansForexTabState extends State<_LoansForexTab> {
  double _monthly = 0;
  double _totalInterest = 0;

  @override
  void initState() {
    super.initState();
    _recalc();
  }

  void _recalc() {
    final tuition = double.tryParse(widget.tuitionCtrl.text.trim()) ?? 0;
    final down = double.tryParse(widget.downCtrl.text.trim()) ?? 0;
    final principal = math.max(0, tuition - down);
    final rate = (double.tryParse(widget.rateCtrl.text.trim()) ?? 0) / 100.0;
    final years = double.tryParse(widget.termCtrl.text.trim()) ?? 0;
    final n = (years * 12).round();
    if (principal <= 0 || n <= 0) {
      setState(() {
        _monthly = 0;
        _totalInterest = 0;
      });
      return;
    }
    final r = rate / 12.0;
    double emi;
    if (r == 0) {
      emi = principal / n;
    } else {
      final pow = math.pow(1 + r, n);
      emi = principal * r * pow / (pow - 1);
    }
    setState(() {
      _monthly = emi;
      _totalInterest = (emi * n) - principal;
    });
  }

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
              Text('Loans & Forex', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Plan tuition payments and currency needs.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              Row(
                children: [
                  Expanded(
                    child: _MetricPill(
                      icon: Icons.attach_money_rounded,
                      label: 'Monthly EMI',
                      value: _monthly == 0
                          ? '—'
                          : _currency(_monthly, prefix: '\$'),
                    ),
                  ),
                  AppSpacing.width10,
                  Expanded(
                    child: _MetricPill(
                      icon: Icons.trending_up_rounded,
                      label: 'Total Interest',
                      value: _monthly == 0
                          ? '—'
                          : _currency(_totalInterest, prefix: '\$'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Calculator + Guidance
        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: [
              _CalcCard(
                tuitionCtrl: widget.tuitionCtrl,
                downCtrl: widget.downCtrl,
                rateCtrl: widget.rateCtrl,
                termCtrl: widget.termCtrl,
                onCalc: _recalc,
              ),
              AppSpacing.height12,
              _GuidanceCard(),
              AppSpacing.height12,
              _ForexTipsCard(),
              AppSpacing.height24,
            ],
          ),
        ),
      ],
    );
  }

  String _currency(double v, {String prefix = ''}) {
    final s = v.toStringAsFixed(2);
    final parts = s.split('.');
    final digits = parts[0];
    final buf = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      final left = digits.length - i - 1;
      buf.write(digits[i]);
      if (left > 0 && left % 3 == 0) buf.write(',');
    }
    return '$prefix${buf.toString()}.${parts[1]}';
  }
}

class _CalcCard extends StatelessWidget {
  final TextEditingController tuitionCtrl;
  final TextEditingController downCtrl;
  final TextEditingController rateCtrl;
  final TextEditingController termCtrl;
  final VoidCallback onCalc;

  const _CalcCard({
    required this.tuitionCtrl,
    required this.downCtrl,
    required this.rateCtrl,
    required this.termCtrl,
    required this.onCalc,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Loan Calculator', style: AppTextStyles.inter600Black16),
            AppSpacing.height10,
            _CalcRow(
              label: 'Tuition / Total',
              controller: tuitionCtrl,
              hint: 'e.g., 30000',
              onChanged: (_) => onCalc(),
            ),
            AppSpacing.height8,
            _CalcRow(
              label: 'Down Payment',
              controller: downCtrl,
              hint: 'e.g., 5000',
              onChanged: (_) => onCalc(),
            ),
            AppSpacing.height8,
            _CalcRow(
              label: 'Annual Interest %',
              controller: rateCtrl,
              hint: 'e.g., 7.5',
              onChanged: (_) => onCalc(),
            ),
            AppSpacing.height8,
            _CalcRow(
              label: 'Term (years)',
              controller: termCtrl,
              hint: 'e.g., 5',
              onChanged: (_) => onCalc(),
            ),
            AppSpacing.height12,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Recalculate',
                    onPressed: onCalc,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CalcRow extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _CalcRow({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 130,
            child: Text(label, style: AppTextStyles.inter600Black16)),
        AppSpacing.width10,
        Expanded(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLines: 1,
            minLines: 1,
            style: AppTextStyles.inter400Black16,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.heading3Regular,
              isDense: true,
              contentPadding: AppSpacing.paddingH12V12,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _GuidanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Guidance', style: AppTextStyles.inter600Black16),
            AppSpacing.height6,
            const _Bullet(
                'Prefer bank transfers or official portals to avoid high fees.'),
            const _Bullet('Pay tuition in tranches to reduce forex risk.'),
            const _Bullet(
                'Keep proof of payment for visa and arrival formalities.'),
          ],
        ),
      ),
    );
  }
}

class _ForexTipsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Forex & Fees Tips', style: AppTextStyles.inter600Black16),
            AppSpacing.height6,
            const _Bullet('Compare bank FX rates vs. remittance providers.'),
            const _Bullet('Avoid weekend conversions (spreads can be wider).'),
            const _Bullet(
                'Maintain a small emergency fund in destination currency.'),
          ],
        ),
      ),
    );
  }
}

// ===================== REUSABLES =====================

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const _SearchField({
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const int maxLines = 1;
    final int minLines = math.min(1, maxLines);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutralLight),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        style: AppTextStyles.inter400Black16,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.heading3Regular,
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.neutralDarkGray),
          border: InputBorder.none,
          contentPadding: AppSpacing.paddingH12V12,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class _MetricPill extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _MetricPill({
    required this.icon,
    required this.label,
    required this.value,
  });

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
          Icon(icon, size: 18, color: AppColors.royalBlue),
          AppSpacing.width8,
          Expanded(
            child: Text(label,
                style: AppTextStyles.heading3Regular,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ),
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

class _Bullet extends StatelessWidget {
  final String text;
  const _Bullet(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_rounded, size: 16, color: AppColors.royalBlue),
          AppSpacing.width6,
          Expanded(child: Text(text, style: AppTextStyles.heading3Light12)),
        ],
      ),
    );
  }
}
