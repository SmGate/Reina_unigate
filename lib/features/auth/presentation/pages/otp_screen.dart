import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:unigate/core/constants/app_assets.dart';
import 'package:unigate/core/constants/app_paddings.dart';
import 'package:unigate/core/routing/routes_enums.dart';
import 'package:unigate/core/theme/app_colors.dart';
import 'package:unigate/core/theme/text_styles.dart';
import 'package:unigate/core/widgets/custom_button.dart';
import 'package:unigate/core/widgets/custom_card.dart';
import 'package:unigate/core/widgets/custom_toast.dart';
import 'package:unigate/core/widgets/app_dialog.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _code = '';

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: AppTextStyles.heading3Light,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        border: Border.all(color: Colors.blue),
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showAppModal(
                context,
                title: 'Verification failed',
                message: state.message,
                type: AppModalType.error,
              );
            }
            if (state is AuthVerifyEmailSuccess) {
              showSuccessToast(context, state.result.message.isEmpty ? 'Email verified' : state.result.message);
              context.pushNamed(Routes.profileSetupMain.name);
            }
            if (state is AuthResendCodeSuccess) {
              showSuccessToast(context, state.result.message.isEmpty ? 'Code resent' : state.result.message);
            }
          },
          child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.background),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset(AppAssets.mainIcons)),
              AppSpacing.height40,
              Padding(
                padding: AppSpacing.paddingH10,
                child: CustomCard(
                  color: AppColors.white,
                  elevation: 4,
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
                        Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Verify Your ',
                                  style: AppTextStyles.displayMediumMedium,
                                ),
                                TextSpan(
                                  text: 'Email',
                                  style: AppTextStyles.displayMediumBold,
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppSpacing.height20,
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTextStyles.heading3Light,
                            children: [
                              const TextSpan(
                                  text: "We’ve sent a code to your email "),
                              TextSpan(
                                text: widget.email,
                                style: AppTextStyles.heading3Light
                                    .copyWith(color: AppColors.oceanBlue),
                              ),
                              const TextSpan(text: ". Please enter it below."),
                            ],
                          ),
                        ),
                        AppSpacing.height30,
                        Center(
                          child: Pinput(
                            length: 6,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            onCompleted: (pin) {
                              setState(() => _code = pin);
                            },
                          ),
                        ),
                        AppSpacing.height40,
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            final isLoading = state is AuthLoading;
                            return Column(
                              children: [
                                CustomButton(
                                  text: isLoading ? "Verifying..." : "Verify",
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          final code = _code;
                                          if (code.length != 6) {
                                            showAppModal(
                                              context,
                                              title: 'Invalid code',
                                              message:
                                                  'Please enter the 6-digit verification code.',
                                              type: AppModalType.warning,
                                            );
                                            return;
                                          }
                                          context.read<AuthBloc>().add(
                                                AuthVerifyEmailSubmitted(
                                                  email: widget.email,
                                                  code: code,
                                                ),
                                              );
                                        },
                                  borderRadius: 300,
                                  width: double.infinity,
                                  textStyle: AppTextStyles.inter400White16,
                                  verticalPadding: 20,
                                ),
                                AppSpacing.height20,
                                TextButton(
                                  onPressed: isLoading
                                      ? null
                                      : () {
                                          context.read<AuthBloc>().add(
                                                AuthResendCodeRequested(
                                                  email: widget.email,
                                                ),
                                              );
                                        },
                                  child: const Text('Resend code'),
                                ),
                              ],
                            );
                          },
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
    );
  }
}

