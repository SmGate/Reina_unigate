import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class LockedScreen extends StatelessWidget {
  final String title;
  final VoidCallback onLogin;

  const LockedScreen({super.key, required this.title, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppSpacing.paddingH16V12,
      children: [
        Container(
          padding: AppSpacing.paddingH16V12,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.skyBlueMid, AppColors.royalBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$title • Locked', style: AppTextStyles.inter400White16),
              AppSpacing.height6,
              Text('Sign in to unlock this feature.',
                  style: AppTextStyles.heading3White),
              AppSpacing.height12,
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      width: double.infinity,
                      text: 'Login / Sign up',
                      onPressed: onLogin,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
