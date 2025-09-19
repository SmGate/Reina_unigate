import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/document_center/data/model/document_models.dart';

import 'summary_chip.dart';
import 'doc_card.dart';

class DocumentsTab extends StatelessWidget {
  final List<DocItem> docs;
  final void Function(DocItem?) onUploadTap;
  final VoidCallback onCreateSop;

  const DocumentsTab({
    super.key,
    required this.docs,
    required this.onUploadTap,
    required this.onCreateSop,
  });

  @override
  Widget build(BuildContext context) {
    final uploaded = docs.where((d) => d.status == DocStatus.uploaded).length;
    final missing = docs.where((d) => d.status == DocStatus.missing).length;
    final drafts = docs.where((d) => d.status == DocStatus.draft).length;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // Header gradient with quick actions
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
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SummaryChip(label: 'Uploaded', value: uploaded.toString()),
                    AppSpacing.width10,
                    SummaryChip(label: 'Missing', value: missing.toString()),
                    AppSpacing.width10,
                    SummaryChip(label: 'Drafts', value: drafts.toString()),
                  ],
                ),
              ),
              AppSpacing.height12,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Upload Document',
                      onPressed: () => onUploadTap(null),
                    ),
                  ),
                  AppSpacing.width10,
                  Expanded(
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Build SOP',
                      onPressed: onCreateSop,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        AppSpacing.height12,

        // Upload portal grid (responsive, no overflow)
        Padding(
          padding: AppSpacing.paddingH16,
          child: LayoutBuilder(
            builder: (context, c) {
              int cols = 1;
              double ratio = 2.9;
              if (c.maxWidth >= 820) {
                cols = 3;
                ratio = 3.6;
              } else if (c.maxWidth >= 520) {
                cols = 2;
                ratio = 3.2;
              }

              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: ratio,
                ),
                itemBuilder: (_, i) => DocCard(
                  item: docs[i],
                  onUploadTap: () => onUploadTap(docs[i]),
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
