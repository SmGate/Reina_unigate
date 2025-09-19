import 'package:flutter/material.dart';
import 'package:unigate/core/theme/text_styles.dart';

class PlaceholderScreen extends StatelessWidget {
  final String label;
  const PlaceholderScreen(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(label, style: AppTextStyles.displayMediumMedium18));
  }
}
