import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/features/chat_supports/data/model/chat_models.dart';

class Bubble extends StatelessWidget {
  final ChatMessage message;
  const Bubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isBot = message.fromBot;
    final bg = isBot ? AppColors.white : AppColors.oceanBlue;
    final textStyle =
        isBot ? AppTextStyles.inter400Black16 : AppTextStyles.heading3White;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isBot ? 4 : 16),
            bottomRight: Radius.circular(isBot ? 16 : 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: AppSpacing.paddingH12V12,
          child: Column(
            crossAxisAlignment:
                isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(message.text, style: textStyle),
              AppSpacing.height6,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.schedule_rounded,
                      size: 14,
                      color: isBot ? AppColors.neutralDarkGray : Colors.white),
                  const SizedBox(width: 4),
                  Text(_fmtTime(message.time),
                      style: AppTextStyles.heading3Light12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _fmtTime(DateTime t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
