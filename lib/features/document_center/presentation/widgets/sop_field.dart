import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class SopField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines; // 1 for title, 6 (default) for paragraphs
  final String hint;

  const SopField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines = 6,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    // Prevent assertion: minLines must be <= maxLines
    final int effectiveMin = math.min(3, maxLines);

    final words = controller.text.trim().isEmpty
        ? 0
        : controller.text.trim().split(RegExp(r'\s+')).length;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
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
            // Header row (no overflow)
            Row(
              children: [
                Expanded(
                  child: Text(label,
                      style: AppTextStyles.inter600Black16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                AppSpacing.width8,
                Text('Words: $words', style: AppTextStyles.heading3Light12),
              ],
            ),
            AppSpacing.height8,
            TextField(
              controller: controller,
              maxLines: maxLines,
              minLines: effectiveMin,
              style: AppTextStyles.inter400Black16,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.heading3Regular,
                isDense: true,
                contentPadding: AppSpacing.paddingH12V12,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (_) {}, // parent rebuild can update if needed
            ),
          ],
        ),
      ),
    );
  }
}
