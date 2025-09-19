import 'dart:convert';
// ignore_for_file: unused_field, unused_element
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart'; // AppSpacing
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/core/services/app_prefs.dart';
import 'package:unigate/injection/injection_container.dart';

class UniExplored extends StatefulWidget {
  const UniExplored({super.key});

  @override
  State<UniExplored> createState() => _UniExploredState();
}

class _UniExploredState extends State<UniExplored> {
  // ---- Mock data (replace later with API) ----
  final List<Map<String, String>> _recommended = const [
    {
      'name': 'Harvard University',
      'country': 'USA',
      'fee': '\$45,000 / year',
      'ranking': '#1',
      'img':
          'https://images.unsplash.com/photo-1503676260728-1c00da094a0b?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'University of Oxford',
      'country': 'UK',
      'fee': '\$40,000 / year',
      'ranking': '#2',
      'img':
          'https://images.unsplash.com/photo-1500043357865-c6b8827edf39?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'MIT',
      'country': 'USA',
      'fee': '\$46,000 / year',
      'ranking': '#3',
      'img':
          'https://images.unsplash.com/photo-1523580846011-d3a5bc25702b?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'University of Toronto',
      'country': 'Canada',
      'fee': '\$32,000 / year',
      'ranking': '#18',
      'img':
          'https://images.unsplash.com/photo-1503674888379-4a8a1f3f1e59?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'ETH Zürich',
      'country': 'Switzerland',
      'fee': '\$28,000 / year',
      'ranking': '#9',
      'img':
          'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?q=80&w=1200&auto=format&fit=crop'
    },
  ];

  final List<Map<String, String>> _favorites = const [
    {
      'name': 'Imperial College London',
      'country': 'UK',
      'fee': '\$39,000 / year',
      'ranking': '#6',
      'img':
          'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'National University of Singapore',
      'country': 'Singapore',
      'fee': '\$30,000 / year',
      'ranking': '#8',
      'img':
          'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=1200&auto=format&fit=crop'
    },
    {
      'name': 'The University of Tokyo',
      'country': 'Japan',
      'fee': '\$27,000 / year',
      'ranking': '#23',
      'img':
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=1200&auto=format&fit=crop'
    },
  ];

  // ---- UI state ----
  final String _search = '';
  final List<String> _filters = const [
    'Country',
    'Course',
    'Tuition Fee',
    'Ranking'
  ];
  final Set<String> _selectedFilters = {};

  static const Color _primary = Color(0xFF2563EB);

  Map<String, dynamic>? _profileSetup;

  @override
  void initState() {
    super.initState();
    _profileSetup = sl<AppPrefs>().getProfileSetup();
    // Debug print of saved profile setup
    try {
      debugPrint('[UniExplored] profileSetup: '
          '${_profileSetup == null ? 'null' : jsonEncode(_profileSetup)}');
    } catch (_) {
      debugPrint('[UniExplored] profileSetup: <failed to encode>');
    }
    // If you want to react to changes later, consider a stream or state management.
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FC),
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: AppColors.white,
      //   title: Text('UniGate', style: AppTextStyles.displayMediumMedium20),
      //   actions: const [
      //     Padding(
      //       padding: AppSpacing.paddingH4,
      //       child: Icon(Icons.favorite_rounded, color: Colors.redAccent),
      //     ),
      //     Padding(
      //       padding: AppSpacing.paddingH8,
      //       child: Icon(Icons.person_rounded, color: AppColors.blackish),
      //     ),
      //   ],
      // ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('AI is preparing recommendations…')),
          );
        },
        backgroundColor: _primary,
        icon: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
        label: const Text(
          'AI Recommend',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Gradient banner + search
          const _GradientBanner(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SearchBar(
                  hint: 'Search universities, courses…',
                ),
                SizedBox(height: 10), // visual spacing inside banner (kept)
                Text(
                  'Discover top universities & tailor your journey.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),

          if (_profileSetup != null) _buildPrefsSummary(),

          // Explore row with Filters button
          Container(
            color: Colors.white,
            padding: AppSpacing.paddingH16V12,
            child: Row(
              children: [
                const Text(
                  'Explore',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                _TinyGhostButton(
                  icon: Icons.tune_rounded,
                  label: 'Filters',
                  onTap: () => _openFilterSheet(context),
                ),
              ],
            ),
          ),

          AppSpacing.height10,

          // Filter chips
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: AppSpacing.paddingH16,
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => AppSpacing.width10,
              itemBuilder: (_, i) {
                final label = _filters[i];
                final selected = _selectedFilters.contains(label);
                return _PillChip(
                  label: label,
                  selected: selected,
                  onTap: () {
                    setState(() {
                      selected
                          ? _selectedFilters.remove(label)
                          : _selectedFilters.add(label);
                    });
                  },
                );
              },
            ),
          ),

          // Recommended
          _SectionHeader(
            title: 'Recommended for you',
            actionText: 'See all',
            onAction: () {},
          ),
          SizedBox(
            height: 260,
            child: ListView.separated(
              padding: AppSpacing.paddingH16,
              scrollDirection: Axis.horizontal,
              itemCount: _recommended.length,
              separatorBuilder: (_, __) => AppSpacing.width16,
              itemBuilder: (_, i) {
                final u = _recommended[i];
                return _UniversityCard(
                  name: u['name']!,
                  country: u['country']!,
                  fee: u['fee']!,
                  ranking: u['ranking']!,
                  imageUrl: u['img']!,
                  onTap: () {},
                  onFav: () {},
                );
              },
            ),
          ),

          // Favorites
          _SectionHeader(
            title: 'Saved favorites',
            actionText: 'Manage',
            onAction: () {},
          ),
          Padding(
            padding: AppSpacing.paddingH16,
            child: Column(
              children: List.generate(_favorites.length, (i) {
                final u = _favorites[i];
                return Padding(
                  padding: EdgeInsets.only(top: i == 0 ? 0 : 10),
                  child: _FavoriteTile(
                    name: u['name']!,
                    country: u['country']!,
                    fee: u['fee']!,
                    ranking: u['ranking']!,
                    imageUrl: u['img']!,
                    onFav: () {},
                  ),
                );
              }),
            ),
          ),
          AppSpacing.height24,
        ],
      ),
    );
  }

  Widget _buildPrefsSummary() {
    final eduIndex = (_profileSetup!['education_level_index'] ?? -1) as int;
    final courses = List<String>.from(_profileSetup!['courses'] ?? const []);
    final cities = List<String>.from(_profileSetup!['cities'] ?? const []);
    String eduLabel;
    switch (eduIndex) {
      case 0:
        eduLabel = 'Matriculation/O-Levels';
        break;
      case 1:
        eduLabel = 'Intermediate/A-Levels';
        break;
      case 2:
        eduLabel = 'Bachelors Degree';
        break;
      case 3:
        eduLabel = 'Masters Degree';
        break;
      case 4:
        eduLabel = 'Other';
        break;
      default:
        eduLabel = 'Not set';
    }

    return Container(
      color: Colors.white,
      padding: AppSpacing.paddingH16V12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your preferences',
              style: AppTextStyles.displayMediumMedium18
                  .copyWith(fontWeight: FontWeight.w700)),
          AppSpacing.height8,
          Text('Education: $eduLabel', style: AppTextStyles.heading3Light),
          AppSpacing.height6,
          if (courses.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: courses
                  .map((c) => Chip(label: Text(c)))
                  .toList(growable: false),
            ),
          if (courses.isNotEmpty) AppSpacing.height6,
          if (cities.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: cities
                  .map((c) => Chip(label: Text(c)))
                  .toList(growable: false),
            ),
        ],
      ),
    );
  }

  // Bottom filter sheet (placeholder UI)
  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        final basePadding = AppSpacing.paddingH16V12.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 4),
        );
        return Padding(
          padding: basePadding,
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
              const Text(
                'Quick Filters',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              AppSpacing.height12,
              const _FilterRow(title: 'Country', hint: 'e.g., USA, UK'),
              AppSpacing.height10,
              const _FilterRow(title: 'Course', hint: 'e.g., Computer Science'),
              AppSpacing.height10,
              const _FilterRow(title: 'Max Tuition Fee', hint: 'e.g., 35000'),
              AppSpacing.height10,
              const _FilterRow(title: 'Min Ranking', hint: 'e.g., Top 50'),
              AppSpacing.height16,
              CustomButton(
                  width: double.infinity,
                  text: "Apply FIlter",
                  onPressed: () {}),
              AppSpacing.height8,
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              AppSpacing.height6,
            ],
          ),
        );
      },
    );
  }
}

// ===================== Reusable Widgets =====================

class _GradientBanner extends StatelessWidget {
  final Widget child;
  const _GradientBanner({required this.child});

  @override
  Widget build(BuildContext context) {
    // Using H16V12 + extra vertical spacing to approximate previous 18 paddings
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingH16V12,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.skyBlueMid, AppColors.royalBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
      ),
      child: child,
    );
  }
}

class _SearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  const _SearchBar({required this.hint, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(.96),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutralLight),
      ),
      child: TextField(
        onChanged: onChanged,
        style: AppTextStyles.inter400Black16,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.heading3Regular,
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.neutralDarkGray),
          suffixIcon: const Icon(Icons.mic_none_rounded,
              color: AppColors.neutralDarkGray),
          border: InputBorder.none,
          contentPadding: AppSpacing.paddingH12V12, // unified spacing
        ),
      ),
    );
  }
}

class _PillChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _PillChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    const primary = AppColors.skyBlueDark;
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 14, vertical: 10), // visual (kept)
        decoration: BoxDecoration(
          color: selected ? AppColors.oceanBlue : AppColors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: selected ? primary : AppColors.neutralLight, width: 1),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: primary.withOpacity(.10),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(
              _iconFor(label),
              size: 18,
              color: selected ? AppColors.white : AppColors.charcoal,
            ),
            AppSpacing.width6,
            Text(
              label,
              style: AppTextStyles.displayMediumMedium12.copyWith(
                fontWeight: FontWeight.w700,
                color: selected ? AppColors.white : AppColors.blackish,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String l) {
    switch (l) {
      case 'Country':
        return Icons.public_rounded;
      case 'Course':
        return Icons.menu_book_rounded;
      case 'Tuition Fee':
        return Icons.payments_rounded;
      case 'Ranking':
        return Icons.emoji_events_rounded;
      default:
        return Icons.tune_rounded;
    }
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onAction;
  const _SectionHeader(
      {required this.title, required this.actionText, required this.onAction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Approximate 16–18–16–10 with H16V12; visual rhythm stays clean and consistent
      padding: AppSpacing.paddingH16V12,
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.displayMediumMedium18
                .copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.arrow_forward_rounded,
                size: 18, color: AppColors.royalBlue),
            label: Text(
              actionText,
              style: AppTextStyles.displayMediumMedium12
                  .copyWith(color: AppColors.royalBlue),
            ),
          ),
        ],
      ),
    );
  }
}

class _UniversityCard extends StatelessWidget {
  final String name;
  final String country;
  final String fee;
  final String ranking;
  final String imageUrl;
  final VoidCallback onTap;
  final VoidCallback onFav;

  const _UniversityCard({
    required this.name,
    required this.country,
    required this.fee,
    required this.ranking,
    required this.imageUrl,
    required this.onTap,
    required this.onFav,
  });

  @override
  Widget build(BuildContext context) {
    const primary = AppColors.skyBlueDark;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      color: AppColors.neutralVeryLight,
                      alignment: Alignment.center,
                      child: const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.neutralLight,
                    alignment: Alignment.center,
                    child: const Icon(Icons.image_not_supported_outlined),
                  ),
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(.08),
                        Colors.black.withOpacity(.38),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  children: [
                    const _Badge(
                        text: '#',
                        icon: Icons.emoji_events_rounded), // visual placeholder
                    const Spacer(),
                    _CircleIconButton(
                      icon: Icons.favorite_border_rounded,
                      onTap: onFav,
                      bg: Colors.white.withOpacity(.24),
                      fg: Colors.white,
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: _GlassCard(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.school_rounded,
                          size: 22, color: AppColors.royalBlue),
                      AppSpacing.width8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.inter400Black16,
                            ),
                            AppSpacing.height2,
                            Text('$country  •  $fee',
                                style: AppTextStyles.heading3Light12),
                          ],
                        ),
                      ),
                      AppSpacing.width8,
                      Container(
                        padding: AppSpacing.paddingH10V8,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Details',
                          style: AppTextStyles.heading3White
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteTile extends StatelessWidget {
  final String name;
  final String country;
  final String fee;
  final String ranking;
  final String imageUrl;
  final VoidCallback onFav;

  const _FavoriteTile({
    required this.name,
    required this.country,
    required this.fee,
    required this.ranking,
    required this.imageUrl,
    required this.onFav,
  });

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(16);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: border,
        child: Row(
          children: [
            SizedBox(
              height: 86,
              width: 86,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (c, w, p) {
                  if (p == null) return w;
                  return Container(
                    color: AppColors.neutralVeryLight,
                    alignment: Alignment.center,
                    child: const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.neutralLight,
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.inter600Black16,
                    ),
                    AppSpacing.height2,
                    Row(
                      children: [
                        const Icon(Icons.public_rounded,
                            size: 16, color: AppColors.neutralDarkGray),
                        AppSpacing.width4,
                        Expanded(
                          child: Text(
                            '$country  •  $ranking',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading3Light12,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.height2,
                    Text(fee, style: AppTextStyles.displaySmall500),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: onFav,
              icon: const Icon(Icons.favorite, color: Colors.redAccent),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final IconData icon;
  const _Badge({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    // Padding values are a bit bespoke; keeping visual values
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.85),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.amber.shade700),
          AppSpacing.width6,
          Text(text, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Padding(padding: AppSpacing.paddingAll12, child: child),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color bg;
  final Color fg;
  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bg,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: AppSpacing.paddingAll2,
          child: Icon(icon, color: fg, size: 20),
        ),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final String title;
  final String hint;
  const _FilterRow({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        AppSpacing.width10,
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              contentPadding: AppSpacing.paddingH12V12,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}

class _TinyGhostButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TinyGhostButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(999);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: radius,
        onTap: onTap,
        child: Container(
          padding: AppSpacing.paddingH10V10,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: radius,
            border: Border.all(
                color: AppColors.skyBlueDark.withOpacity(.25), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppColors.skyBlueDark),
              AppSpacing.width6,
              Text(label, style: AppTextStyles.displaySmall500),
            ],
          ),
        ),
      ),
    );
  }
}
