import 'package:flutter/material.dart';
import 'package:unigate/core/theme/text_styles.dart';

class StatusPillSmall extends StatelessWidget {
  final String text;
  final Color fg;
  final Color bg;
  const StatusPillSmall(
      {super.key, required this.text, required this.fg, required this.bg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Text(text, style: AppTextStyles.displaySmall500),
    );
  }
}
