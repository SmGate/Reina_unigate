import 'package:equatable/equatable.dart';
import 'package:unigate/features/auth/domain/entities/login_entity.dart';
import 'package:unigate/features/auth/domain/entities/signup_entity.dart';
import 'package:unigate/features/auth/domain/entities/verify_email_entity.dart';
import 'package:unigate/features/auth/domain/entities/resend_code_entity.dart';
import 'package:unigate/features/auth/domain/entities/forgot_password_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoginSuccess extends AuthState {
  const AuthLoginSuccess(this.user);
  final LoginEntity user;
  @override
  List<Object?> get props => [user];
}

class AuthLoginUnverified extends AuthState {
  const AuthLoginUnverified(this.email, {this.message});
  final String email;
  final String? message;
  @override
  List<Object?> get props => [email, message];
}

class AuthSignupSuccess extends AuthState {
  const AuthSignupSuccess(this.user);
  final SignupEntity user;
  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}

class AuthVerifyEmailSuccess extends AuthState {
  const AuthVerifyEmailSuccess(this.result);
  final VerifyEmailEntity result;
  @override
  List<Object?> get props => [result];
}

class AuthResendCodeSuccess extends AuthState {
  const AuthResendCodeSuccess(this.result);
  final ResendCodeEntity result;
  @override
  List<Object?> get props => [result];
}

class AuthForgotPasswordSuccess extends AuthState {
  const AuthForgotPasswordSuccess(this.result);
  final ForgotPasswordEntity result;
  @override
  List<Object?> get props => [result];
}



