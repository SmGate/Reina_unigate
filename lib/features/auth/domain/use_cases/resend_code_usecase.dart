import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/core/usecase/usecase.dart';
import 'package:unigate/features/auth/domain/entities/resend_code_entity.dart';
import 'package:unigate/features/auth/domain/repositories/auth_repository.dart';

class ResendCodeUseCase implements UseCase<ResendCodeEntity, ResendCodeParams> {
  ResendCodeUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, ResendCodeEntity>> call(ResendCodeParams params) {
    return _repository.resendCode(email: params.email);
  }
}

class ResendCodeParams extends Equatable {
  const ResendCodeParams({required this.email});

  final String email;

  Map<String, dynamic> toJson() => {
        'email': email,
      };

  @override
  List<Object?> get props => [email];
}


