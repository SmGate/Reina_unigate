import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/core/widgets/custom_card.dart';

class SignupOptionsPage extends StatelessWidget {
  const SignupOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(AppAssets.background))),
            child: Column(
              children: [
                AppSpacing.height20,
                Image.asset(AppAssets.mainIcons),
                AppSpacing.height40,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(AppAssets.getStarted),
                ),
                // Fixed bottom CustomCard without spacing
                CustomCard(
                  elevation: 2,
                  color: AppColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        30), // Optional: for inside spacing
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButton(
                          text: "Signup",
                          onPressed: () {
                            context.pushNamed(Routes.userSignup.name);
                          },
                          borderRadius: 300,
                          width: double.infinity,
                          textStyle: AppTextStyles.inter400White16,
                          verticalPadding: 20,
                        ),
                        AppSpacing.height20,
                        CustomButton(
                          text: "Sign-in to UniGate",
                          onPressed: () {
                            context.goNamed(Routes.login.name);
                          },
                          borderRadius: 300,
                          width: double.infinity,
                          backgroundColor: AppColors.white,
                          borderColor: AppColors.neutralGray,
                          textStyle: AppTextStyles.inter400Black16,
                          verticalPadding: 20,
                        ),
                        AppSpacing.height20,
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: AppColors.neutralGray),
                            ),
                            Padding(
                              padding: AppSpacing.paddingH20,
                              child: Text("or",
                                  style: AppTextStyles.heading3Light),
                            ),
                            const Expanded(
                              child: Divider(color: AppColors.neutralGray),
                            ),
                          ],
                        ),
                        AppSpacing.height20,
                        CustomButton(
                          text: "Continue with Google",
                          onPressed: () {},
                          borderRadius: 300,
                          width: double.infinity,
                          backgroundColor: AppColors.white,
                          borderColor: AppColors.neutralGray,
                          textStyle: AppTextStyles.inter400Black16,
                          verticalPadding: 20,
                          icon: Image.asset(
                            AppAssets.googleLogo,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

