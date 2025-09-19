import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/core/widgets/custom_card.dart';
import 'package:unigate/core/services/app_prefs.dart';
import 'package:unigate/injection/injection_container.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/features/profile_setup/presentation/widgets/citiese_section.dart';
import 'package:unigate/features/profile_setup/presentation/widgets/courses_subject.dart';
import 'package:unigate/features/profile_setup/presentation/widgets/education_section.dart';
import 'package:unigate/features/profile_setup/presentation/widgets/profile_completion_model.dart';
import 'package:unigate/features/profile_setup/presentation/widgets/stepper.dart';

class ProfileSetupMainPage extends StatefulWidget {
  const ProfileSetupMainPage({super.key});

  @override
  State<ProfileSetupMainPage> createState() => _ProfileSetupMainPageState();
}

class _ProfileSetupMainPageState extends State<ProfileSetupMainPage> {
  int _currentStep = -1;
  final int _totalSteps = 3;
  int _educationIndex = -1;
  Set<String> _courses = {};
  Set<String> _cities = {};

  void _goToNextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > -1) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _finishAndSave() async {
    final prefs = sl<AppPrefs>();
    await prefs.saveProfileSetup(
      educationLevelIndex: _educationIndex,
      selectedCourses: _courses.toList(),
      selectedCities: _cities.toList(),
    );
    await prefs.setProfileSetupCompleted(true);
    context.goNamed(Routes.login.name);
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
            ),
          ),
          child: Column(
            children: [
              AppSpacing.height40,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: StepperWidget(currentStep: _currentStep),
              ),
              AppSpacing.height20,
              Expanded(
                child: CustomCard(
                  color: AppColors.neutralUltraLight,
                  elevation: 4,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: _buildStepContent(),
                        ),
                      ),
                      _currentStep == 2
                          ? const SizedBox()
                          : SizedBox(
                              height: 80,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (_currentStep > -1)
                                      CustomButton(
                                        borderRadius: 300,
                                        text: "Previous",
                                        backgroundColor: AppColors.white,
                                        borderColor: AppColors.neutralMid,
                                        textStyle:
                                            AppTextStyles.displayMediumMedium12,
                                        icon: const Icon(Icons.arrow_back),
                                        horizontalPadding: 20,
                                        onPressed: _goToPreviousStep,
                                      )
                                    else
                                      const SizedBox(width: 80),
                                    CustomButton(
                                      borderRadius: 300,
                                      horizontalPadding: 20,
                                      textStyle: AppTextStyles
                                          .displayMediumMedium12
                                          .copyWith(
                                        color: AppColors.white,
                                      ),
                                      text: _currentStep == _totalSteps - 1
                                          ? "Finish"
                                          : "Next",
                                      onPressed: _currentStep == _totalSteps - 1
                                          ? _finishAndSave
                                          : _goToNextStep,
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

  Widget _buildStepContent() {
    switch (_currentStep) {
      case -1:
        return EducationSection(
          onChanged: (v) => _educationIndex = v ?? -1,
        );
      case 0:
        return CoursesAndSubjectSection(
          onChanged: (v) => _courses = v,
        );

      case 1:
        return CitieseSection(
          onChanged: (v) => _cities = v,
        );
      case 2:
        return const Center(child: ProfileCompletion());
      default:
        return EducationSection(onChanged: (v) => _educationIndex = v ?? -1);
    }
  }
}
