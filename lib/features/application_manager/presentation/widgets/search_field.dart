import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutralLight),
      ),
      child: TextField(
        onChanged: onChanged,
        style: AppTextStyles.inter400Black16,
        decoration: InputDecoration(
          hintText: 'Search by university, program, or country',
          hintStyle: AppTextStyles.heading3Regular,
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.neutralDarkGray),
          border: InputBorder.none,
          contentPadding: AppSpacing.paddingH12V12,
        ),
      ),
    );
  }
}
