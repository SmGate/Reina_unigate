import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/features/document_center/data/model/document_models.dart';

import 'status_pill_small.dart';

class DocCard extends StatelessWidget {
  final DocItem item;
  final VoidCallback onUploadTap;
  const DocCard({super.key, required this.item, required this.onUploadTap});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    final style = _statusParts(item.status);

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
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              padding: AppSpacing.paddingAll10,
              child: Icon(style.icon, color: style.fg, size: 20),
            ),
            AppSpacing.width10,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.type,
                          style: AppTextStyles.inter600Black16,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      AppSpacing.width8,
                      StatusPillSmall(
                          text: style.label, fg: style.fg, bg: style.bg),
                    ],
                  ),
                  AppSpacing.height2,
                  Text(
                    'Size: ${item.size}',
                    style: AppTextStyles.heading3Light12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            AppSpacing.width10,
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 96, maxWidth: 120),
              child: CustomButton(
                width: double.infinity,
                text: item.status == DocStatus.uploaded ? 'Replace' : 'Upload',
                onPressed: onUploadTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _StatusStyle _statusParts(DocStatus s) {
    switch (s) {
      case DocStatus.missing:
        return _StatusStyle(
          label: 'Missing',
          fg: const Color(0xFFC62828),
          bg: const Color(0xFFFFEBEE),
          icon: Icons.error_outline_rounded,
        );
      case DocStatus.draft:
        return _StatusStyle(
          label: 'Draft',
          fg: AppColors.royalBlue,
          bg: const Color(0xFFE8F0FE),
          icon: Icons.edit_note_rounded,
        );
      case DocStatus.uploading:
        return _StatusStyle(
          label: 'Uploading',
          fg: const Color(0xFFB26A00),
          bg: const Color(0xFFFFF7E8),
          icon: Icons.cloud_upload_rounded,
        );
      case DocStatus.uploaded:
        return _StatusStyle(
          label: 'Uploaded',
          fg: const Color(0xFF2E7D32),
          bg: const Color(0xFFEFF7EE),
          icon: Icons.verified_rounded,
        );
    }
  }
}

class _StatusStyle {
  final String label;
  final Color fg;
  final Color bg;
  final IconData icon;
  _StatusStyle(
      {required this.label,
      required this.fg,
      required this.bg,
      required this.icon});
}
