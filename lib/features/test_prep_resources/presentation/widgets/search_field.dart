import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  const SearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const int maxLines = 1;
    final int minLines = math.min(1, maxLines);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutralLight),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
        style: AppTextStyles.inter400Black16,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.heading3Regular,
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.neutralDarkGray),
          border: InputBorder.none,
          contentPadding: AppSpacing.paddingH12V12,
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class MiniChip extends StatelessWidget {
  final String text;
  const MiniChip(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0FE),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text, style: AppTextStyles.displaySmall500),
    );
  }
}

class ChipRow extends StatelessWidget {
  final List<Widget> children;
  const ChipRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 6, runSpacing: 6, children: children);
  }
}

class Bullet extends StatelessWidget {
  final String text;
  const Bullet(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_rounded, size: 16, color: AppColors.royalBlue),
          AppSpacing.width6,
          Expanded(child: Text(text, style: AppTextStyles.heading3Light12)),
        ],
      ),
    );
  }
}

class LinkPill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const LinkPill({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: AppColors.neutralLight, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.03),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.open_in_new_rounded,
                  size: 16, color: AppColors.skyBlueDark),
              const SizedBox(width: 6),
              Text(label, style: AppTextStyles.inter400Black16),
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownPill extends StatelessWidget {
  final String label; // not displayed, kept for semantics
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const DropdownPill({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.neutralLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: AppTextStyles.inter400Black16),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
        ),
      ),
    );
  }
}

class SelectablePill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const SelectablePill({
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
        child: Text(label, style: textStyle),
      ),
    );
  }
}

class DateRow extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onPick;
  const DateRow({
    super.key,
    required this.label,
    required this.value,
    required this.onPick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingH12V12,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.neutralLight),
      ),
      child: Row(
        children: [
          Text(label, style: AppTextStyles.inter600Black16),
          const Spacer(),
          Text(value,
              style: AppTextStyles.heading3Regular,
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          const SizedBox(width: 6),
          IconButton(
            onPressed: onPick,
            icon: const Icon(Icons.edit_calendar_rounded,
                color: AppColors.skyBlueDark),
          ),
        ],
      ),
    );
  }
}
