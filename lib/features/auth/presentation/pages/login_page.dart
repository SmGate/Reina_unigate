import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/core/widgets/custom_card.dart';
import 'package:unigate/core/widgets/app_dialog.dart';
import 'package:unigate/core/widgets/custom_textfield.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/core/services/app_prefs.dart';
import 'package:unigate/injection/injection_container.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showAppModal(
                context,
                title: 'Login failed',
                message: state.message,
                type: AppModalType.error,
                primaryLabel: 'Try again',
              );
            }
            if (state is AuthLoginUnverified) {
              showAppModal(
                context,
                title: 'Email not verified',
                message: state.message ?? 'Please verify your email before logging in.',
                type: AppModalType.warning,
                primaryLabel: 'Verify now',
                onPrimary: () => context.push('/otpScreen/${state.email}'),
              );
            }
            if (state is AuthLoginSuccess) {
              showAppModal(
                context,
                title: 'Welcome',
                message: 'Logged in as ${state.user.fullName}',
                type: AppModalType.success,
                primaryLabel: 'Continue',
                onPrimary: () async {
                  await sl<AppPrefs>().setGuest(false);
                  context.goNamed(Routes.appShell.name);
                },
              );
            }
          },
          child: SizedBox.expand(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppAssets.background),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSpacing.height20,
                  Image.asset(AppAssets.mainIcons),
                  AppSpacing.height40,
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomCard(
                      elevation: 2,
                      color: AppColors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Padding(
                        padding: AppSpacing.paddingH20V20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Back 👋",
                              style: AppTextStyles.displayMediumBold,
                            ),
                            AppSpacing.height10,
                            Text(
                              "Please login to your account",
                              style: AppTextStyles.heading3Light,
                            ),
                            AppSpacing.height30,
                            RoundedInputField(
                              controller: emailController,
                              hintText: "Email Address",
                              hintTextStyle: AppTextStyles.heading3Light,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            AppSpacing.height20,
                            RoundedInputField(
                              controller: passwordController,
                              hintText: "Password",
                              hintTextStyle: AppTextStyles.heading3Light,
                              isPassword: true,
                            ),
                            AppSpacing.height30,
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                final isLoading = state is AuthLoading;
                                return CustomButton(
                                  text: isLoading ? "Please wait..." : "Login",
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          final email =
                                              emailController.text.trim();
                                          final password =
                                              passwordController.text.trim();
                                          context.read<AuthBloc>().add(
                                                AuthLoginSubmitted(
                                                  email: email,
                                                  password: password,
                                                ),
                                              );
                                        },
                                  borderRadius: 300,
                                  width: double.infinity,
                                  textStyle: AppTextStyles.inter400White16,
                                  verticalPadding: 20,
                                );
                              },
                            ),
                            AppSpacing.height10,
                            CustomButton(
                              text: "Visit as Guest",
                              onPressed: () async {
                                await sl<AppPrefs>().setGuest(true);
                                context.goNamed(Routes.appShell.name);
                              },
                              borderRadius: 300,
                              width: double.infinity,
                              backgroundColor: AppColors.white,
                              borderColor: AppColors.neutralGray,
                              textStyle: AppTextStyles.inter400Black16,
                              verticalPadding: 20,
                            ),
                            AppSpacing.height10,
                            Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  context.pushNamed(Routes.forgotPassword.name);
                                },
                                child: const Text('Forgot Password?'),
                              ),
                            ),
                            AppSpacing.height10,
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  context.goNamed(Routes.signUpOptions.name);
                                },
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Don\'t have an account? ',
                                        style: AppTextStyles.inter400Black16,
                                      ),
                                      TextSpan(
                                        text: 'Sign up',
                                        style: AppTextStyles.displaySmall500,
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


