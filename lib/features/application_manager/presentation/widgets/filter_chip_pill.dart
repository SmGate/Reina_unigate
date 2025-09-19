import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class FilterChipPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const FilterChipPill({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.oceanBlue : AppColors.white;
    final border = selected ? AppColors.skyBlueDark : AppColors.neutralLight;
    final textStyle =
        selected ? AppTextStyles.heading3White : AppTextStyles.inter400Black16;

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: border, width: 1),
          boxShadow: [
            if (selected)
              BoxShadow(
                color: AppColors.skyBlueDark.withOpacity(.12),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(_iconFor(label),
                size: 18, color: selected ? Colors.white : AppColors.charcoal),
            AppSpacing.width6,
            Text(label, style: textStyle),
          ],
        ),
      ),
    );
  }

  IconData _iconFor(String l) {
    switch (l) {
      case 'Country':
        return Icons.public_rounded;
      case 'Program':
        return Icons.menu_book_rounded;
      case 'Deadline':
        return Icons.event_rounded;
      case 'Status':
        return Icons.flag_rounded;
      default:
        return Icons.tune_rounded;
    }
  }
}
