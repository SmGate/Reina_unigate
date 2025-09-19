import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/core/usecase/usecase.dart';
import 'package:unigate/features/auth/domain/entities/verify_email_entity.dart';
import 'package:unigate/features/auth/domain/repositories/auth_repository.dart';

class VerifyEmailUseCase implements UseCase<VerifyEmailEntity, VerifyEmailParams> {
  VerifyEmailUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, VerifyEmailEntity>> call(VerifyEmailParams params) {
    return _repository.verifyEmail(email: params.email, code: params.code);
  }
}

class VerifyEmailParams extends Equatable {
  const VerifyEmailParams({required this.email, required this.code});

  final String email;
  final String code;

  Map<String, dynamic> toJson() => {
        'email': email,
        'code': code,
      };

  @override
  List<Object?> get props => [email, code];
}


