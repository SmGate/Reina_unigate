import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';

class ProfileCompletion extends StatelessWidget {
  const ProfileCompletion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            color: AppColors.neutralMid,
          ),
          AppSpacing.height20,
          Text(
            "Almost there",
            style: AppTextStyles.displayMediumBold,
          ),
          AppSpacing.height20,
          Text(
            "Unlock Your Best Matches",
            style: AppTextStyles.displayMediumMedium20,
          ),
          AppSpacing.height20,
          Padding(
            padding: AppSpacing.paddingH20,
            child: Text(
              "Your profile is set! To get even more precise university and course recommendations tailored just for you, take a quick, optional quiz.It's fast and fun!",
              style: AppTextStyles.heading3Light,
              textAlign: TextAlign.center,
            ),
          ),
          AppSpacing.height20,
          Padding(
            padding: AppSpacing.paddingH20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: "Go to Dashboard",
                  onPressed: () {
                    context.pushNamed(Routes.appShell.name);
                  },
                  borderRadius: 300,
                  backgroundColor: AppColors.oceanBlue,
                  textStyle: AppTextStyles.heading3White,
                  borderColor: AppColors.neutralMid,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
