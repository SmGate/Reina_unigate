// ignore_for_file: unused_field
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class ExploreLearnScreen extends StatefulWidget {
  const ExploreLearnScreen({super.key});

  @override
  State<ExploreLearnScreen> createState() => _ExploreLearnScreenState();
}

class _ExploreLearnScreenState extends State<ExploreLearnScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // ===== Mock Data =====
  final List<_BlogPost> _blogs = [
    _BlogPost(
      title: 'Finding Housing in Toronto',
      author: 'Ayesha R.',
      date: DateTime(2025, 3, 12),
      country: 'Canada',
      tags: ['Housing', 'Budget'],
      preview:
          'Tips on landlords, neighborhoods, transit times, and how to avoid scams.',
      banner:
          'https://images.unsplash.com/photo-1503674888379-4a8a1f3f1e59?q=80&w=1200&auto=format&fit=crop',
    ),
    _BlogPost(
      title: 'Surviving UK Winters',
      author: 'Omar K.',
      date: DateTime(2025, 1, 22),
      country: 'UK',
      tags: ['Lifestyle', 'Health'],
      preview:
          'Layering, Vitamin D, and student discounts—everything to keep you warm & sane.',
      banner:
          'https://images.unsplash.com/photo-1500043357865-c6b8827edf39?q=80&w=1200&auto=format&fit=crop',
    ),
    _BlogPost(
      title: 'Part-time Jobs for STEM Students',
      author: 'Mei Lin',
      date: DateTime(2025, 2, 8),
      country: 'USA',
      tags: ['Jobs', 'STEM'],
      preview:
          'On-campus gigs, CPT/OPT basics, and balancing labs with work hours.',
      banner:
          'https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?q=80&w=1200&auto=format&fit=crop',
    ),
    _BlogPost(
      title: 'Your First Week in Singapore',
      author: 'Arjun S.',
      date: DateTime(2025, 4, 4),
      country: 'Singapore',
      tags: ['Orientation', 'Culture'],
      preview:
          'Campus cards, transport cards, hawker centers—and what to do first.',
      banner:
          'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=1200&auto=format&fit=crop',
    ),
  ];

  final List<_Webinar> _webinars = [
    _Webinar(
      title: 'Study in Germany: Visa & Blocked Account',
      dateTime: DateTime(2025, 9, 12, 16, 0),
      host: 'UniGate Advisors',
      mode: 'Online',
      link: 'https://example.com/germany-visa',
    ),
    _Webinar(
      title: 'IELTS Writing Task 2 Live Workshop',
      dateTime: DateTime(2025, 10, 2, 18, 30),
      host: 'IELTS Mentor',
      mode: 'Online',
      link: 'https://example.com/ielts-workshop',
    ),
    _Webinar(
      title: 'Part-time Work & Internships in Canada',
      dateTime: DateTime(2025, 8, 25, 17, 0),
      host: 'Co-op Career Center',
      mode: 'Online',
      link: 'https://example.com/canada-jobs',
    ),
  ];

  final List<_PDTask> _pdChecklist = [
    _PDTask('Passport valid for 6+ months', true),
    _PDTask('Visa/BRP letter printed', false),
    _PDTask('University enrollment letter', false),
    _PDTask('Accommodation confirmation', true),
    _PDTask('Travel insurance & health docs', false),
    _PDTask('Emergency contacts & copies', false),
    _PDTask('Currency / Travel card setup', false),
    _PDTask('Local SIM options researched', false),
  ];

  // ===== State =====
  // Blogs
  final _blogSearchCtrl = TextEditingController();
  String _blogQuery = '';
  String _blogCountry = 'All';
  String _blogTopic = 'All';
  final List<String> _countries = const [
    'All',
    'USA',
    'UK',
    'Canada',
    'Germany',
    'Australia',
    'Singapore'
  ];
  final List<String> _topics = const [
    'All',
    'Housing',
    'Jobs',
    'Lifestyle',
    'Health',
    'STEM',
    'Orientation',
    'Culture'
  ];

  // Webinars
  final _webinarSearchCtrl = TextEditingController();
  String _webinarQuery = '';
  String _timeFilter = 'Upcoming';
  final List<String> _timeOptions = const ['Upcoming', 'Past', 'All'];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _blogSearchCtrl.dispose();
    _webinarSearchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        title:
            Text('Explore & Learn', style: AppTextStyles.displayMediumMedium20),
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
                    child: Text('Blogs',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('Webinars',
                        style: AppTextStyles.displayMediumMedium12)),
                Tab(
                    child: Text('Pre-Departure',
                        style: AppTextStyles.displayMediumMedium12)),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _BlogsTab(
            blogs: _blogs,
            ctrl: _blogSearchCtrl,
            query: _blogQuery,
            onQuery: (v) => setState(() => _blogQuery = v),
            country: _blogCountry,
            topic: _blogTopic,
            countries: _countries,
            topics: _topics,
            onCountry: (v) => setState(() => _blogCountry = v),
            onTopic: (v) => setState(() => _blogTopic = v),
            onOpen: _openBlog,
          ),
          _WebinarsTab(
            webinars: _webinars,
            ctrl: _webinarSearchCtrl,
            query: _webinarQuery,
            onQuery: (v) => setState(() => _webinarQuery = v),
            timeFilter: _timeFilter,
            timeOptions: _timeOptions,
            onTimeFilter: (v) => setState(() => _timeFilter = v),
            onOpen: _openWebinar,
          ),
          _PreDepartureTab(
            tasks: _pdChecklist,
            onSave: () => setState(() {}),
          ),
        ],
      ),
    );
  }

  // ===== Actions =====
  void _openBlog(_BlogPost b) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _BlogDetailSheet(post: b),
    );
  }

  void _openWebinar(_Webinar w) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _WebinarSheet(webinar: w),
    );
  }
}

// ===================== MODELS =====================

class _BlogPost {
  final String title;
  final String author;
  final DateTime date;
  final String country;
  final List<String> tags;
  final String preview;
  final String banner;

  _BlogPost({
    required this.title,
    required this.author,
    required this.date,
    required this.country,
    required this.tags,
    required this.preview,
    required this.banner,
  });
}

class _Webinar {
  final String title;
  final DateTime dateTime;
  final String host;
  final String mode;
  final String link;
  _Webinar({
    required this.title,
    required this.dateTime,
    required this.host,
    required this.mode,
    required this.link,
  });
}

class _PDTask {
  final String title;
  bool done;
  _PDTask(this.title, this.done);
}

// ===================== TAB: BLOGS =====================

class _BlogsTab extends StatelessWidget {
  final List<_BlogPost> blogs;
  final TextEditingController ctrl;
  final String query;
  final ValueChanged<String> onQuery;
  final String country;
  final String topic;
  final List<String> countries;
  final List<String> topics;
  final ValueChanged<String> onCountry;
  final ValueChanged<String> onTopic;
  final void Function(_BlogPost) onOpen;

  const _BlogsTab({
    required this.blogs,
    required this.ctrl,
    required this.query,
    required this.onQuery,
    required this.country,
    required this.topic,
    required this.countries,
    required this.topics,
    required this.onCountry,
    required this.onTopic,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final filtered = blogs.where((b) {
      final matchQ = query.trim().isEmpty ||
          b.title.toLowerCase().contains(query.toLowerCase()) ||
          b.preview.toLowerCase().contains(query.toLowerCase()) ||
          b.tags.join(' ').toLowerCase().contains(query.toLowerCase());
      final matchCountry = country == 'All' || b.country == country;
      final matchTopic = topic == 'All' || b.tags.contains(topic);
      return matchQ && matchCountry && matchTopic;
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
              Text('Student Blogs & Articles',
                  style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Stories and tips from students around the world.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              _SearchField(
                controller: ctrl,
                hint: 'Search articles, topics…',
                onChanged: onQuery,
              ),
              AppSpacing.height10,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _DropdownPill(
                    label: 'Country',
                    value: country,
                    items: countries,
                    onChanged: onCountry,
                  ),
                  _DropdownPill(
                    label: 'Topic',
                    value: topic,
                    items: topics,
                    onChanged: onTopic,
                  ),
                ],
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Grid of blog cards (height made responsive to text scale to prevent overflow)
        Padding(
          padding: AppSpacing.paddingH16,
          child: LayoutBuilder(
            builder: (context, c) {
              final scale = MediaQuery.textScaleFactorOf(context);
              final extra = (scale > 1.0) ? (scale - 1.0) * 70.0 : 0.0;

              int cols;
              double baseExtent;
              if (c.maxWidth >= 900) {
                cols = 3;
                baseExtent = 300; // was 280
              } else if (c.maxWidth >= 600) {
                cols = 2;
                baseExtent = 312; // was 290
              } else {
                cols = 1;
                baseExtent = 332; // was 300
              }
              final extent = baseExtent + extra;

              return GridView.builder(
                itemCount: filtered.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: extent, // responsive fixed height
                ),
                itemBuilder: (_, i) => _BlogCard(
                    post: filtered[i], onOpen: () => onOpen(filtered[i])),
              );
            },
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }
}

class _BlogCard extends StatelessWidget {
  final _BlogPost post;
  final VoidCallback onOpen;
  const _BlogCard({required this.post, required this.onOpen});

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
      child: ClipRRect(
        borderRadius: radius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            SizedBox(
              height: 120,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    post.banner,
                    fit: BoxFit.cover,
                    loadingBuilder: (c, w, p) {
                      if (p == null) return w;
                      return Container(
                        color: AppColors.neutralVeryLight,
                        alignment: Alignment.center,
                        child: const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.neutralVeryLight,
                      alignment: Alignment.center,
                      child: const Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(.05),
                          Colors.black.withOpacity(.35)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: _MiniChip(post.country),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: AppSpacing.paddingH12V12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title,
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  AppSpacing.height2,
                  Row(
                    children: [
                      const Icon(Icons.person_rounded,
                          size: 16, color: AppColors.neutralDarkGray),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text('${post.author} • ${_fmtDate(post.date)}',
                            style: AppTextStyles.heading3Light12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  AppSpacing.height6,
                  Text(
                    post.preview,
                    style: AppTextStyles.inter400Black16,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AppSpacing.height8,
                  _ChipRow(
                      children: post.tags.map((t) => _MiniChip(t)).toList()),
                  AppSpacing.height8, // slightly reduced spacing to help fit
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          width: double.infinity,
                          text: 'Read',
                          onPressed: onOpen,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}

class _BlogDetailSheet extends StatelessWidget {
  final _BlogPost post;
  const _BlogDetailSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH16V12.add(
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(post.title, style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height6,
            Row(
              children: [
                const Icon(Icons.person_rounded,
                    size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 4),
                Expanded(
                  child: Text('${post.author} • ${_fmtDate(post.date)}',
                      style: AppTextStyles.heading3Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            AppSpacing.height10,
            _ChipRow(children: [
              _MiniChip(post.country),
              ...post.tags.map((t) => _MiniChip(t)),
            ]),
            AppSpacing.height12,
            Text(
              '${post.preview}\n\nThis is a longer mock article body. Add sections like housing portals, verified groups, transport passes, average costs, and safety notes. Use bullet points and official links for credibility.',
              style: AppTextStyles.inter400Black16,
            ),
            AppSpacing.height12,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Close',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            AppSpacing.height6,
          ],
        ),
      ),
    );
  }

  String _fmtDate(DateTime d) {
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}

// ===================== TAB: WEBINARS =====================

class _WebinarsTab extends StatelessWidget {
  final List<_Webinar> webinars;
  final TextEditingController ctrl;
  final String query;
  final ValueChanged<String> onQuery;
  final String timeFilter;
  final List<String> timeOptions;
  final ValueChanged<String> onTimeFilter;
  final void Function(_Webinar) onOpen;

  const _WebinarsTab({
    required this.webinars,
    required this.ctrl,
    required this.query,
    required this.onQuery,
    required this.timeFilter,
    required this.timeOptions,
    required this.onTimeFilter,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final filtered = webinars.where((w) {
      final hit = query.trim().isEmpty ||
          w.title.toLowerCase().contains(query.toLowerCase()) ||
          w.host.toLowerCase().contains(query.toLowerCase());
      bool timeOk = true;
      if (timeFilter == 'Upcoming') timeOk = w.dateTime.isAfter(now);
      if (timeFilter == 'Past') timeOk = w.dateTime.isBefore(now);
      return hit && timeOk;
    }).toList()
      ..sort((a, b) => a.dateTime.compareTo(b.dateTime));

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
              Text('Webinars & Events', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Join upcoming info sessions and live Q&A.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              _SearchField(
                controller: ctrl,
                hint: 'Search webinar or host…',
                onChanged: onQuery,
              ),
              AppSpacing.height10,
              _DropdownPill(
                label: 'Time',
                value: timeFilter,
                items: timeOptions,
                onChanged: onTimeFilter,
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: List.generate(filtered.length, (i) {
              final w = filtered[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _WebinarTile(webinar: w, onOpen: () => onOpen(w)),
              );
            }),
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }
}

class _WebinarTile extends StatelessWidget {
  final _Webinar webinar;
  final VoidCallback onOpen;
  const _WebinarTile({required this.webinar, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    final isOnline = webinar.mode.toLowerCase().contains('online');

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
              padding: AppSpacing.paddingAll10,
              decoration: BoxDecoration(
                color: isOnline
                    ? const Color(0xFFEAF4FF)
                    : const Color(0xFFFFF3E0),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isOnline ? Icons.videocam_rounded : Icons.event_seat_rounded,
                color:
                    isOnline ? AppColors.skyBlueDark : const Color(0xFFB26A00),
                size: 22,
              ),
            ),
            AppSpacing.width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(webinar.title,
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  AppSpacing.height2,
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded,
                          size: 16, color: AppColors.neutralDarkGray),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(_fmtDateTime(webinar.dateTime),
                            style: AppTextStyles.heading3Light12,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  AppSpacing.height2,
                  Row(
                    children: [
                      const Icon(Icons.mic_none_rounded,
                          size: 16, color: AppColors.neutralDarkGray),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text('${webinar.host} • ${webinar.mode}',
                            style: AppTextStyles.heading3Regular,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AppSpacing.width10,
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 96, maxWidth: 120),
              child: CustomButton(
                width: double.infinity,
                text: 'Open',
                onPressed: onOpen,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _fmtDateTime(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$y-$m-$d • $hh:$mm';
  }
}

class _WebinarSheet extends StatelessWidget {
  final _Webinar webinar;
  const _WebinarSheet({required this.webinar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacing.paddingH16V12.add(
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Container(
              width: 44,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(webinar.title, style: AppTextStyles.displayMediumMedium18),
            AppSpacing.height6,
            _ChipRow(children: [
              _MiniChip(_fmtDateTime(webinar.dateTime)),
              _MiniChip(webinar.mode),
            ]),
            AppSpacing.height10,
            Row(
              children: [
                const Icon(Icons.mic_none_rounded,
                    size: 16, color: AppColors.neutralDarkGray),
                const SizedBox(width: 4),
                Expanded(
                  child: Text('Host: ${webinar.host}',
                      style: AppTextStyles.heading3Regular,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            AppSpacing.height12,
            Text(
              'Session overview:\n• What to prepare\n• Live Q&A with experts\n• Resources & next steps',
              style: AppTextStyles.inter400Black16,
            ),
            AppSpacing.height12,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Open Link',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            AppSpacing.height6,
          ],
        ),
      ),
    );
  }

  String _fmtDateTime(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final hh = dt.hour.toString().padLeft(2, '0');
    final mm = dt.minute.toString().padLeft(2, '0');
    return '$y-$m-$d • $hh:$mm';
  }
}

// ===================== TAB: PRE-DEPARTURE =====================

class _PreDepartureTab extends StatefulWidget {
  final List<_PDTask> tasks;
  final VoidCallback onSave;
  const _PreDepartureTab({required this.tasks, required this.onSave});

  @override
  State<_PreDepartureTab> createState() => _PreDepartureTabState();
}

class _PreDepartureTabState extends State<_PreDepartureTab> {
  late List<_PDTask> _local;

  @override
  void initState() {
    super.initState();
    _local = widget.tasks.map((t) => _PDTask(t.title, t.done)).toList();
  }

  double get _progress =>
      _local.isEmpty ? 0 : _local.where((e) => e.done).length / _local.length;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Header with progress
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
              Text('Pre-Departure Guide', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Checklist & essential tips before you fly.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              _LinearProgress(value: _progress),
              AppSpacing.height6,
              Row(
                children: [
                  const Icon(Icons.check_circle_rounded,
                      size: 16, color: Colors.white),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Completed ${((_progress * 100).round())}%',
                      style: AppTextStyles.heading3White,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Checklist + Tips
        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: [
              _ChecklistCard(
                tasks: _local,
                onToggle: (i, v) => setState(() => _local[i].done = v),
                onSave: () {
                  for (int i = 0; i < widget.tasks.length; i++) {
                    widget.tasks[i].done = _local[i].done;
                  }
                  widget.onSave();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pre-departure saved')),
                  );
                },
              ),
              AppSpacing.height12,
              _ResourcesCard(),
              AppSpacing.height12,
              _PackingCard(),
              AppSpacing.height24,
            ],
          ),
        ),
      ],
    );
  }
}

class _ChecklistCard extends StatelessWidget {
  final List<_PDTask> tasks;
  final void Function(int, bool) onToggle;
  final VoidCallback onSave;
  const _ChecklistCard({
    required this.tasks,
    required this.onToggle,
    required this.onSave,
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
            Text('Checklist', style: AppTextStyles.inter600Black16),
            AppSpacing.height6,
            ...List.generate(tasks.length, (i) {
              final t = tasks[i];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    Checkbox(
                      value: t.done,
                      onChanged: (v) => onToggle(i, v ?? false),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Expanded(
                      child:
                          Text(t.title, style: AppTextStyles.inter400Black16),
                    ),
                  ],
                ),
              );
            }),
            AppSpacing.height10,
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    width: double.infinity,
                    text: 'Save',
                    onPressed: onSave,
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

class _ResourcesCard extends StatelessWidget {
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
            Text('Key Resources', style: AppTextStyles.inter600Black16),
            AppSpacing.height6,
            const _Bullet('Airport immigration & baggage rules.'),
            const _Bullet('Local transport cards & student discounts.'),
            const _Bullet('Emergency numbers and embassy contacts.'),
            AppSpacing.height10,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _LinkPill(label: 'Arrival Guide', onTap: () {}),
                _LinkPill(label: 'Student Insurance', onTap: () {}),
                _LinkPill(label: 'Housing Safety', onTap: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PackingCard extends StatelessWidget {
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
            Text('Packing Tips', style: AppTextStyles.inter600Black16),
            AppSpacing.height6,
            const _ChipRow(children: [
              _MiniChip('Travel adapter'),
              _MiniChip('Essential meds'),
              _MiniChip('Warm layers'),
              _MiniChip('Document copies'),
            ]),
            AppSpacing.height8,
            Text(
              'Pack light but smart: essentials, a week of clothes, and items not easily found on arrival. Keep documents in cabin baggage.',
              style: AppTextStyles.inter400Black16,
            ),
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

class _LinkPill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LinkPill({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.open_in_new_rounded,
                  size: 16, color: AppColors.skyBlueDark),
              const SizedBox(width: 6),
              Text(label, style: AppTextStyles.inter400Black16),
            ],
          ),
        ),
      ),
    );
  }
}
