import 'package:unigate/core/network/dio_client.dart';
import 'package:unigate/core/network/list_api.dart';
import 'package:unigate/features/auth/data/model/signup_response_model.dart';
import 'package:unigate/features/auth/data/model/login_response_model.dart';
import 'package:unigate/features/auth/data/model/verify_email_response_model.dart';
import 'package:unigate/features/auth/data/model/resend_code_response_model.dart';
import 'package:unigate/features/auth/data/model/forgot_password_response_model.dart';
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/core/errors/exceptions.dart' as app_exceptions;
import 'package:unigate/features/auth/domain/entities/signup_entity.dart';

abstract class AuthRemoteDataSource {
  Future<SignupEntity> signup({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String password,
  });

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<VerifyEmailResponseModel> verifyEmail({
    required String email,
    required String code,
  });

  Future<ResendCodeResponseModel> resendCode({
    required String email,
  });

  Future<ForgotPasswordResponseModel> forgotPassword({
    required String email,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<SignupEntity> signup({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String password,
  }) async {
    final result = await _client.postRequest<SignupResponseModel>(
      ListAPI.registerUser,
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'mobile': mobile,
        'email': email,
        'password': password,
      },
      converter: (json) => SignupResponseModel.fromJson(json as Map<String, dynamic>),
      isIsolate: false,
    );

    return result.match(
      (l) {
        final String message = l is ServerFailure ? l.message : l.toString();
        throw app_exceptions.ServerException(message);
      },
      (r) => r,
    );
  }

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final result = await _client.postRequest<LoginResponseModel>(
      ListAPI.loginUser,
      data: {
        'email': email,
        'password': password,
      },
      converter: (json) => LoginResponseModel.fromJson(json as Map<String, dynamic>),
      isIsolate: false,
    );

    return result.match(
      (l) {
        final String message = l is ServerFailure ? l.message : l.toString();
        throw app_exceptions.ServerException(message);
      },
      (r) => r,
    );
  }

  @override
  Future<VerifyEmailResponseModel> verifyEmail({
    required String email,
    required String code,
  }) async {
    final result = await _client.postRequest<VerifyEmailResponseModel>(
      ListAPI.verifyEmail,
      data: {
        'email': email,
        'code': code,
      },
      converter: (json) =>
          VerifyEmailResponseModel.fromJson(json as Map<String, dynamic>),
      isIsolate: false,
    );

    return result.match(
      (l) {
        final String message = l is ServerFailure ? l.message : l.toString();
        throw app_exceptions.ServerException(message);
      },
      (r) => r,
    );
  }

  @override
  Future<ResendCodeResponseModel> resendCode({
    required String email,
  }) async {
    final result = await _client.postRequest<ResendCodeResponseModel>(
      ListAPI.resendCode,
      data: {
        'email': email,
      },
      converter: (json) =>
          ResendCodeResponseModel.fromJson(json as Map<String, dynamic>),
      isIsolate: false,
    );

    return result.match(
      (l) {
        final String message = l is ServerFailure ? l.message : l.toString();
        throw app_exceptions.ServerException(message);
      },
      (r) => r,
    );
  }

  @override
  Future<ForgotPasswordResponseModel> forgotPassword({
    required String email,
  }) async {
    final result = await _client.postRequest<ForgotPasswordResponseModel>(
      ListAPI.forgotPassword,
      data: {
        'email': email,
      },
      converter: (json) =>
          ForgotPasswordResponseModel.fromJson(json as Map<String, dynamic>),
      isIsolate: false,
    );

    return result.match(
      (l) {
        final String message = l is ServerFailure ? l.message : l.toString();
        throw app_exceptions.ServerException(message);
      },
      (r) => r,
    );
  }
}


