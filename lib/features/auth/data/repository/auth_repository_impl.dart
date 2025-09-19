import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/exceptions.dart' as app_exceptions;
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/core/network/network_info.dart';
import 'package:unigate/features/auth/data/datasource/remote_data_source/auth_remote_data_source.dart';
import 'package:unigate/features/auth/data/datasource/local_data_source/auth_local_data_source.dart';
import 'package:unigate/features/auth/domain/entities/signup_entity.dart';
import 'package:unigate/features/auth/domain/entities/login_entity.dart';
import 'package:unigate/features/auth/domain/repositories/auth_repository.dart';
import 'package:unigate/features/auth/domain/entities/verify_email_entity.dart';
import 'package:unigate/features/auth/domain/entities/resend_code_entity.dart';
import 'package:unigate/features/auth/domain/entities/forgot_password_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
    required this.localDataSource,
  });

  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final AuthLocalDataSource localDataSource;

  @override
  Future<Either<Failure, SignupEntity>> signup({
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(MachineFailure('No internet connection'));
    }

    try {
      final entity = await remoteDataSource.signup(
        firstName: firstName,
        lastName: lastName,
        mobile: mobile,
        email: email,
        password: password,
      );
      // cache minimal signup info for guest display
      await localDataSource.cacheSignup(entity);
      return Right(entity);
    } on app_exceptions.ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } on app_exceptions.GeneralException catch (e) {
      return Left(MachineFailure(e.message ?? 'Unexpected error'));
    } on Exception catch (e) {
      return Left(MachineFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(MachineFailure('No internet connection'));
    }
    try {
      final model = await remoteDataSource.login(email: email, password: password);
      await localDataSource.cacheLogin(model);
      return Right(model);
    } on app_exceptions.ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } on app_exceptions.GeneralException catch (e) {
      return Left(MachineFailure(e.message ?? 'Unexpected error'));
    } on Exception catch (e) {
      return Left(MachineFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VerifyEmailEntity>> verifyEmail({
    required String email,
    required String code,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(MachineFailure('No internet connection'));
    }
    try {
      final model = await remoteDataSource.verifyEmail(email: email, code: code);
      return Right(model);
    } on app_exceptions.ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } on app_exceptions.GeneralException catch (e) {
      return Left(MachineFailure(e.message ?? 'Unexpected error'));
    } on Exception catch (e) {
      return Left(MachineFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResendCodeEntity>> resendCode({
    required String email,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(MachineFailure('No internet connection'));
    }
    try {
      final model = await remoteDataSource.resendCode(email: email);
      return Right(model);
    } on app_exceptions.ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } on app_exceptions.GeneralException catch (e) {
      return Left(MachineFailure(e.message ?? 'Unexpected error'));
    } on Exception catch (e) {
      return Left(MachineFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordEntity>> forgotPassword({
    required String email,
  }) async {
    if (!await networkInfo.isConnected) {
      return Left(MachineFailure('No internet connection'));
    }
    try {
      final model = await remoteDataSource.forgotPassword(email: email);
      return Right(model);
    } on app_exceptions.ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } on app_exceptions.GeneralException catch (e) {
      return Left(MachineFailure(e.message ?? 'Unexpected error'));
    } on Exception catch (e) {
      return Left(MachineFailure(e.toString()));
    }
  }
}


