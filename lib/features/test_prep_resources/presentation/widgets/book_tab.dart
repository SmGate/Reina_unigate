import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_center.dart';
import 'package:unigate/features/test_prep_resources/presentation/widgets/search_field.dart';

import '../widgets/center_tile.dart';

class BookTab extends StatefulWidget {
  final List<TestCenter> centers;
  final TextEditingController searchCtrl;
  final String testFilter;
  final List<String> testOptions;
  final ValueChanged<String> onFilterChanged;
  final void Function(TestCenter) onOpenCenter;

  const BookTab({
    super.key,
    required this.centers,
    required this.searchCtrl,
    required this.testFilter,
    required this.testOptions,
    required this.onFilterChanged,
    required this.onOpenCenter,
  });

  @override
  State<BookTab> createState() => _BookTabState();
}

class _BookTabState extends State<BookTab> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final results = widget.centers.where((c) {
      final q = _q.toLowerCase();
      final hit = _q.trim().isEmpty ||
          c.provider.toLowerCase().contains(q) ||
          c.region.toLowerCase().contains(q) ||
          c.test.toLowerCase().contains(q);
      final testOk = widget.testFilter == 'All' ||
          c.test.toLowerCase() == widget.testFilter.toLowerCase();
      return hit && testOk;
    }).toList();

    return ListView(
      padding: EdgeInsets.zero,
      children: [
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
              Text('Book a Test', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Find official providers & booking portals.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              SearchField(
                controller: widget.searchCtrl,
                hint: 'Search provider, region, or test…',
                onChanged: (v) => setState(() => _q = v),
              ),
              AppSpacing.height10,
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  DropdownPill(
                    label: 'Test',
                    value: widget.testFilter,
                    items: widget.testOptions,
                    onChanged: widget.onFilterChanged,
                  ),
                ],
              ),
            ],
          ),
        ),
        AppSpacing.height12,

        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: List.generate(results.length, (i) {
              final c = results[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CenterTile(center: c, onOpen: () => widget.onOpenCenter(c)),
              );
            }),
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }
}
