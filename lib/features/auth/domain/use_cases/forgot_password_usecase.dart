import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/core/usecase/usecase.dart';
import 'package:unigate/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:unigate/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordParams {
  ForgotPasswordParams({required this.email});
  final String email;
}

class ForgotPasswordUseCase
    implements UseCase<ForgotPasswordEntity, ForgotPasswordParams> {
  ForgotPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, ForgotPasswordEntity>> call(
      ForgotPasswordParams params) async {
    return _repository.forgotPassword(email: params.email);
  }
}



