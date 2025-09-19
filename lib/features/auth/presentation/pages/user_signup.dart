import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/app_dialog.dart';
import 'package:unigate/core/widgets/country_picker.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/core/widgets/custom_card.dart';
import 'package:unigate/core/widgets/custom_textfield.dart';
import 'package:unigate/core/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_state.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _dispatchSignup(BuildContext context) {
    if (_formKey.currentState?.validate() != true) return;
    context.read<AuthBloc>().add(
          AuthSignupSubmitted(
            firstName: firstNameController.text.trim(),
            lastName: lastNameController.text.trim(),
            mobile: phoneController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text,
          ),
        );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showAppModal(
                context,
                title: 'Signup failed',
                message: state.message.isEmpty
                    ? 'Something went wrong. Please try again.'
                    : state.message,
                type: AppModalType.error,
                primaryLabel: 'Try again',
              );
            }
            if (state is AuthSignupSuccess) {
              showAppModal(
                context,
                title: 'Verify your account',
                message:
                    'We sent a 6-digit code to ${emailController.text.trim()}. Enter it on the next screen to complete signup.',
                type: AppModalType.success,
                primaryLabel: 'Go to OTP',
                onPrimary: () => context.push('/otpScreen/${emailController.text.trim()}'),
                secondaryLabel: 'Later',
                onSecondary: () {},
              );
              context.push('/otpScreen/${emailController.text.trim()}');
            }
          },
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.background),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacing.height40,
                    Center(child: Image.asset(AppAssets.mainIcons)),
                    AppSpacing.height40,

                    // Full-height card
                    CustomCard(
                      color: AppColors.white,
                      elevation: 4,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Create your ',
                                      style: AppTextStyles.displayMediumMedium,
                                    ),
                                    TextSpan(
                                      text: 'account',
                                      style: AppTextStyles.displayMediumBold,
                                    ),
                                  ],
                                ),
                              ),
                              AppSpacing.height10,
                              Text(
                                "Enter your details to start applying to universities across Pakistan.",
                                style: AppTextStyles.heading3Light,
                              ),
                              AppSpacing.height40,
                              Text("Personal Info",
                                  style: AppTextStyles.displayMediumMedium18),
                              AppSpacing.height20,
                              RoundedInputField(
                                controller: firstNameController,
                                hintText: "First Name",
                                hintTextStyle: AppTextStyles.heading3Light,
                                validator: Validator.validateName,
                                suffix: Image.asset(
                                  AppAssets.user,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              AppSpacing.height20,
                              RoundedInputField(
                                controller: lastNameController,
                                hintText: "Last Name",
                                hintTextStyle: AppTextStyles.heading3Light,
                                validator: Validator.validateName,
                                suffix: Image.asset(
                                  AppAssets.user,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              AppSpacing.height20,
                              RoundedInputField(
                                controller: emailController,
                                hintText: "Email Address",
                                hintTextStyle: AppTextStyles.heading3Light,
                                validator: Validator.validateEmail,
                                suffix: Image.asset(
                                  AppAssets.email,
                                  height: 20,
                                  width: 20,
                                ),
                              ),
                              AppSpacing.height20,
                              CountryCodePhoneField(
                                controller: phoneController,
                                hintText: "000000000",
                                hintTextStyle: AppTextStyles.heading3Light,
                                validator: Validator.validatePhone,
                              ),
                              AppSpacing.height40,
                              Text("Security Details",
                                  style: AppTextStyles.displayMediumMedium18),
                              AppSpacing.height20,
                              RoundedInputField(
                                isPassword: true,
                                controller: passwordController,
                                hintText: "Password",
                                hintTextStyle: AppTextStyles.heading3Light,
                                validator: Validator.validatePassword,
                              ),
                              AppSpacing.height20,
                              RoundedInputField(
                                isPassword: true,
                                controller: confirmpasswordController,
                                hintText: "Confirm Password",
                                hintTextStyle: AppTextStyles.heading3Light,
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Confirm your password';
                                  }
                                  if (v != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              AppSpacing.height40,
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  final isLoading = state is AuthLoading;
                                  return CustomButton(
                                    text:
                                        isLoading ? "Please wait..." : "Signup",
                                    onPressed: isLoading
                                        ? null
                                        : () => _dispatchSignup(context),
                                    borderRadius: 300,
                                    width: double.infinity,
                                    textStyle: AppTextStyles.inter400White16,
                                    verticalPadding: 20,
                                  );
                                },
                              ),
                              AppSpacing.height20,
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Don’t have an Account? ',
                                        style: AppTextStyles.inter400Black16,
                                      ),
                                      TextSpan(
                                        text: 'Sign In',
                                        style: AppTextStyles.displaySmall500,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
