import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/features/auth/domain/entities/login_entity.dart';
import 'package:unigate/features/auth/domain/entities/signup_entity.dart';
import 'package:unigate/features/auth/domain/entities/verify_email_entity.dart';
import 'package:unigate/features/auth/domain/entities/resend_code_entity.dart';
import 'package:unigate/features/auth/domain/entities/forgot_password_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, SignupEntity>> signup({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String password,
  });

  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, VerifyEmailEntity>> verifyEmail({
    required String email,
    required String code,
  });

  Future<Either<Failure, ResendCodeEntity>> resendCode({
    required String email,
  });

  Future<Either<Failure, ForgotPasswordEntity>> forgotPassword({
    required String email,
  });
}


