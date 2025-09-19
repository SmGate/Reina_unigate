import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/application_manager/data/model/application_models.dart';

class StatusPill extends StatelessWidget {
  final AppStatus status;
  const StatusPill({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    IconData icon;

    switch (status) {
      case AppStatus.draft:
        bg = const Color(0xFFE8F0FE);
        fg = AppColors.royalBlue;
        icon = Icons.edit_rounded;
        break;
      case AppStatus.awaitingDocs:
        bg = const Color(0xFFFFF7E8);
        fg = const Color(0xFFB26A00);
        icon = Icons.upload_file_rounded;
        break;
      case AppStatus.inReview:
        bg = const Color(0xFFEAF4FF);
        fg = AppColors.skyBlueDark;
        icon = Icons.search_rounded;
        break;
      case AppStatus.accepted:
        bg = const Color(0xFFEFF7EE);
        fg = const Color(0xFF2E7D32);
        icon = Icons.verified_rounded;
        break;
      case AppStatus.rejected:
        bg = const Color(0xFFFFEBEE);
        fg = const Color(0xFFC62828);
        icon = Icons.cancel_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(999)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: fg),
          AppSpacing.width6,
          Text(
            status.label,
            style: status == AppStatus.draft
                ? AppTextStyles.displaySmall500
                : AppTextStyles.inter400Black16,
          ),
        ],
      ),
    );
  }
}
