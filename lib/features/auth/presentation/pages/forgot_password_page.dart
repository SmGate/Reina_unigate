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
import 'package:unigate/injection/injection_container.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_state.dart';
import 'package:unigate/features/auth/data/datasource/local_data_source/auth_local_data_source.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _prefillEmail();
  }

  Future<void> _prefillEmail() async {
    try {
      final cached = await sl<AuthLocalDataSource>().getCachedLogin();
      if (cached != null && cached.email.isNotEmpty) {
        _emailController.text = cached.email;
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showAppModal(
                context,
                title: 'Request failed',
                message: state.message,
                type: AppModalType.error,
                primaryLabel: 'Try again',
              );
            }
            if (state is AuthForgotPasswordSuccess) {
              showAppModal(
                context,
                title: 'Check your email',
                message: state.result.message.isEmpty
                    ? 'We have sent a reset link to your email.'
                    : state.result.message,
                type: AppModalType.success,
                primaryLabel: 'Back to Login',
                onPrimary: () => context.goNamed(Routes.login.name),
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
                                'Forgot Password',
                                style: AppTextStyles.displayMediumBold,
                              ),
                              AppSpacing.height10,
                              Text(
                                'Enter your email to receive a reset link',
                                style: AppTextStyles.heading3Light,
                              ),
                              AppSpacing.height30,
                              RoundedInputField(
                                controller: _emailController,
                                hintText: 'Email Address',
                                hintTextStyle: AppTextStyles.heading3Light,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              AppSpacing.height30,
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  final bool isLoading = state is AuthLoading;
                                  return CustomButton(
                                    text: isLoading
                                        ? 'Please wait...'
                                        : 'Send Reset Link',
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            final email =
                                                _emailController.text.trim();
                                            if (email.isEmpty) return;
                                            context.read<AuthBloc>().add(
                                                  AuthForgotPasswordSubmitted(
                                                    email: email,
                                                  ),
                                                );
                                          },
                                    borderRadius: 300,
                                    width: double.infinity,
                                    textStyle:
                                        AppTextStyles.inter400White16,
                                    verticalPadding: 20,
                                  );
                                },
                              ),
                              AppSpacing.height10,
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () =>
                                      context.goNamed(Routes.login.name),
                                  child: const Text('Back to Login'),
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



