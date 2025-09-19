import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/constants/app_strings.dart';
import 'package:unigate/core/constants/app_values.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/core/widgets/custom_card.dart';
import 'package:unigate/core/services/app_prefs.dart';
import 'package:unigate/injection/injection_container.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingPageData> pages = const [
    _OnboardingPageData(
      image: AppAssets.onboarding1,
      title: AppString.findYour,
      subtitle: AppString.perfectUniversityMatch,
      description: AppString.exploreUniversities,
    ),
    _OnboardingPageData(
      image: AppAssets.onboarding2,
      title: AppString.applyTo,
      subtitle: AppString.applyToUniversities,
      description: AppString.applySteps,
    ),
    _OnboardingPageData(
      image: AppAssets.onboarding3,
      title: AppString.trackYour,
      subtitle: AppString.trackYourApplication,
      description: AppString.applicationUpdates,
    ),
  ];

  void _goToPage(int index) {
    if (index >= 0 && index < pages.length) {
      _pageController.animateToPage(
        index,
        duration: AppValues.duration,
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.background),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: Column(
            children: [
              // Main Content (Images)
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        AppSpacing.height20,
                        Image.asset(
                          AppAssets.mainIcons,
                        ),
                        const SizedBox(height: AppValues.heightLG20),
                        Image.asset(
                          pages[index].image,
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Bottom Card
              CustomCard(
                elevation: 2,
                color: AppColors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: Padding(
                  padding: AppSpacing.paddingH20V20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Page Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(pages.length, (index) {
                          final isActive = _currentPage == index;
                          return AnimatedContainer(
                            duration: AppValues.durationFast,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 4,
                            width: isActive ? 24 : 10,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.oceanBlue
                                  : AppColors.neutralGray,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          );
                        }),
                      ),

                      AppSpacing.height20,

                      // Title
                      Text(
                        pages[_currentPage].title,
                        style: AppTextStyles.displayMediumBold,
                        textAlign: TextAlign.center,
                      ),

                      AppSpacing.height20,

                      // Subtitle
                      Text(
                        pages[_currentPage].subtitle,
                        style: AppTextStyles.displayMediumMedium20,
                        textAlign: TextAlign.center,
                      ),

                      AppSpacing.height20,

                      // Description
                      Text(
                        pages[_currentPage].description,
                        style: AppTextStyles.heading3Light,
                        textAlign: TextAlign.center,
                      ),

                      AppSpacing.height30,

                      // Navigation Buttons
                      Row(
                        children: [
                          // Skip Button
                          TextButton(
                            onPressed: () async {
                              await sl<AppPrefs>().setOnboardingSeen(true);
                              context.goNamed(Routes.signUpOptions.name);
                            },
                            child: Text(
                              AppString.skip,
                              style: AppTextStyles.heading3Light,
                            ),
                          ),
                          const Spacer(),

                          // Back Button
                          CustomButton(
                            text: "",
                            onPressed: () {},
                            isRounded: true,
                            roundedIcon: const Icon(
                              Icons.arrow_back,
                              color: AppColors.neutralGray,
                            ),
                            onRoundedPressed: () {
                              if (_currentPage > 0) {
                                _goToPage(_currentPage - 1);
                              }
                            },
                            backgroundColor: AppColors.white,
                            borderColor: AppColors.neutralGray,
                          ),
                          AppSpacing.width20,
                          // Forward Button
                          CustomButton(
                            text: "",
                            onPressed: () {},
                            isRounded: true,
                            roundedIcon: const Icon(
                              Icons.arrow_forward,
                              color: AppColors.white,
                            ),
                            onRoundedPressed: () async {
                              if (_currentPage == pages.length - 1) {
                                await sl<AppPrefs>().setOnboardingSeen(true);
                                context.goNamed(Routes.signUpOptions.name);
                              } else {
                                _goToPage(_currentPage + 1);
                              }
                            },
                            backgroundColor: AppColors.oceanBlue,
                            borderColor: AppColors.oceanBlue,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  final String image;
  final String title;
  final String subtitle;
  final String description;

  const _OnboardingPageData({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
  });
}
