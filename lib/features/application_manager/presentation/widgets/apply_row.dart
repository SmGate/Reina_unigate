import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/text_styles.dart';

class ApplyRow extends StatelessWidget {
  final String label;
  final String hint;
  const ApplyRow({super.key, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 110,
            child: Text(label, style: AppTextStyles.inter600Black16)),
        AppSpacing.width10,
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.heading3Regular,
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
