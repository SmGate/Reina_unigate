import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/application_manager/presentation/widgets/search_field.dart';
import 'package:unigate/features/test_prep_resources/data/model/model_guid.dart';
import '../widgets/guide_card.dart';

class GuidesTab extends StatefulWidget {
  final List<Guide> guides;
  final TextEditingController searchCtrl;
  final void Function(Guide) onOpen;

  const GuidesTab({
    super.key,
    required this.guides,
    required this.searchCtrl,
    required this.onOpen,
  });

  @override
  State<GuidesTab> createState() => _GuidesTabState();
}

class _GuidesTabState extends State<GuidesTab> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final results = widget.guides
        .where((g) =>
            _q.trim().isEmpty ||
            g.name.toLowerCase().contains(_q.toLowerCase()) ||
            g.format.toLowerCase().contains(_q.toLowerCase()) ||
            g.scoreScale.toLowerCase().contains(_q.toLowerCase()))
        .toList();

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
              Text('IELTS/TOEFL Guide', style: AppTextStyles.inter400White16),
              AppSpacing.height2,
              Text('Preparation tips, score scales, useful links.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              SearchField(
                onChanged: (v) => setState(() => _q = v),
              ),
            ],
          ),
        ),
        AppSpacing.height12,
        Padding(
          padding: AppSpacing.paddingH16,
          child: LayoutBuilder(
            builder: (context, c) {
              int cols;
              double cardHeight;
              if (c.maxWidth >= 900) {
                cols = 2;
                cardHeight = 210;
              } else if (c.maxWidth >= 600) {
                cols = 2;
                cardHeight = 220;
              } else {
                cols = 1;
                cardHeight = 230;
              }
              return GridView.builder(
                itemCount: results.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: cardHeight,
                ),
                itemBuilder: (_, i) => GuideCard(
                  guide: results[i],
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
