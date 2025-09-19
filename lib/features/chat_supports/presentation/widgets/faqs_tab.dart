import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/chat_supports/data/model/chat_models.dart';
import 'package:unigate/features/chat_supports/presentation/widgets/search_bar.dart';
import 'faq_tile.dart';

class FaqsTab extends StatefulWidget {
  final List<FaqItem> faqs;
  final TextEditingController search;
  final void Function(FaqItem item) onOpen;

  const FaqsTab({
    super.key,
    required this.faqs,
    required this.search,
    required this.onOpen,
  });

  @override
  State<FaqsTab> createState() => _FaqsTabState();
}

class _FaqsTabState extends State<FaqsTab> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.faqs
        .where((f) =>
            _q.trim().isEmpty ||
            f.title.toLowerCase().contains(_q.toLowerCase()) ||
            f.body.toLowerCase().contains(_q.toLowerCase()))
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
              Text('FAQs & Help', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Find answers fast.', style: AppTextStyles.heading3White),
              AppSpacing.height12,
              SearchBarWid(
                controller: widget.search,
                hint: 'Search help articles…',
                onChanged: (v) => setState(() => _q = v),
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // List
        Padding(
          padding: AppSpacing.paddingH16,
          child: Column(
            children: List.generate(filtered.length, (i) {
              final f = filtered[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FaqTile(item: f, onOpen: () => widget.onOpen(f)),
              );
            }),
          ),
        ),
        AppSpacing.height24,
      ],
    );
  }
}
