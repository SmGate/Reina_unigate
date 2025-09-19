import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unigate/features/auth/domain/use_cases/login_usecase.dart';
import 'package:unigate/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:unigate/features/auth/domain/use_cases/verify_email_usecase.dart';
import 'package:unigate/features/auth/domain/use_cases/resend_code_usecase.dart';
import 'package:unigate/features/auth/domain/use_cases/forgot_password_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase,
    required this.verifyEmailUseCase,
    required this.resendCodeUseCase,
    required this.forgotPasswordUseCase,
  }) : super(const AuthInitial()) {
    on<AuthLoginSubmitted>(_onLogin);
    on<AuthSignupSubmitted>(_onSignup);
    on<AuthVerifyEmailSubmitted>(_onVerifyEmail);
    on<AuthResendCodeRequested>(_onResendCode);
    on<AuthForgotPasswordSubmitted>(_onForgotPassword);
  }

  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  final VerifyEmailUseCase verifyEmailUseCase;
  final ResendCodeUseCase resendCodeUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  Future<void> _onLogin(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await loginUseCase(LoginParams(
      email: event.email,
      password: event.password,
    ));
    result.match(
      (failure) => emit(AuthFailure(failure.toString())),
      (user) {
        // If backend indicates not verified, emit a special success to guide to OTP
        if (user.isVerified == false) {
          emit(AuthLoginUnverified(user.email,
              message: 'Please verify your email before logging in.'));
        } else {
          emit(AuthLoginSuccess(user));
        }
      },
    );
  }

  Future<void> _onSignup(
    AuthSignupSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await signupUseCase(SignupParams(
      firstName: event.firstName,
      lastName: event.lastName,
      mobile: event.mobile,
      email: event.email,
      password: event.password,
    ));
    result.match(
      (failure) => emit(AuthFailure(failure.toString())),
      (user) => emit(AuthSignupSuccess(user)),
    );
  }

  Future<void> _onVerifyEmail(
    AuthVerifyEmailSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await verifyEmailUseCase(
      VerifyEmailParams(email: event.email, code: event.code),
    );
    result.match(
      (failure) => emit(AuthFailure(failure.toString())),
      (entity) => emit(AuthVerifyEmailSuccess(entity)),
    );
  }

  Future<void> _onResendCode(
    AuthResendCodeRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await resendCodeUseCase(
      ResendCodeParams(email: event.email),
    );
    result.match(
      (failure) => emit(AuthFailure(failure.toString())),
      (entity) => emit(AuthResendCodeSuccess(entity)),
    );
  }

  Future<void> _onForgotPassword(
    AuthForgotPasswordSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await forgotPasswordUseCase(
      ForgotPasswordParams(email: event.email),
    );
    result.match(
      (failure) => emit(AuthFailure(failure.toString())),
      (entity) => emit(AuthForgotPasswordSuccess(entity)),
    );
  }
}



