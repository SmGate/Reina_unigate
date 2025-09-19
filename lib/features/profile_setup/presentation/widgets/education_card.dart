import 'package:flutter/material.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/custom_decoration.dart';
import 'package:unigate/core/theme/text_styles.dart';

class EducationCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback? onTap;

  const EducationCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        decoration: customContainerDecoration(
          color: AppColors.white,
          borderColor: isSelected ? AppColors.oceanBlue : AppColors.neutralMid,
          borderRadius: 6,
        ),
        child: Padding(
          padding: AppSpacing.paddingH10V10,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                decoration: customContainerDecoration(
                  color:
                      isSelected ? AppColors.oceanBlue : AppColors.neutralLight,
                  borderRadius: 300,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    image,
                    height: 30,
                    width: 30,
                    color: isSelected ? AppColors.white : null,
                    colorBlendMode: isSelected ? BlendMode.srcIn : null,
                  ),
                ),
              ),
              AppSpacing.width20,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.inter400Black16),
                    AppSpacing.height10,
                    Text(subtitle, style: AppTextStyles.heading3Light12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
