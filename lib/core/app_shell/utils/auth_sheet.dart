import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

Future<void> showAuthSheet(
  BuildContext context, {
  required String title,
  required String message,
  required VoidCallback onSignIn,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => Padding(
      padding: AppSpacing.paddingH16V12.add(
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 6),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(title, style: AppTextStyles.displayMediumMedium18),
          AppSpacing.height8,
          Text(message, style: AppTextStyles.heading3Regular),
          AppSpacing.height12,
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  width: double.infinity,
                  text: 'Continue as Guest',
                  textStyle: AppTextStyles.heading3White,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              AppSpacing.width10,
              Expanded(
                child: CustomButton(
                  width: double.infinity,
                  text: 'Sign in',
                  textStyle: AppTextStyles.heading3White,
                  onPressed: () {
                    Navigator.pop(context);
                    onSignIn();
                  },
                ),
              ),
            ],
          ),
          AppSpacing.height6,
        ],
      ),
    ),
  );
}
