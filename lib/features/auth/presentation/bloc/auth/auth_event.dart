import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AuthLoginSubmitted extends AuthEvent {
  const AuthLoginSubmitted({required this.email, required this.password});
  final String email;
  final String password;
  @override
  List<Object?> get props => [email, password];
}

class AuthSignupSubmitted extends AuthEvent {
  const AuthSignupSubmitted({
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.password,
  });
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String password;

  @override
  List<Object?> get props => [firstName, lastName, mobile, email, password];
}

class AuthVerifyEmailSubmitted extends AuthEvent {
  const AuthVerifyEmailSubmitted({required this.email, required this.code});
  final String email;
  final String code;
  @override
  List<Object?> get props => [email, code];
}

class AuthResendCodeRequested extends AuthEvent {
  const AuthResendCodeRequested({required this.email});
  final String email;
  @override
  List<Object?> get props => [email];
}

class AuthForgotPasswordSubmitted extends AuthEvent {
  const AuthForgotPasswordSubmitted({required this.email});
  final String email;
  @override
  List<Object?> get props => [email];
}



