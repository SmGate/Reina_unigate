import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/core/usecase/usecase.dart';
import 'package:unigate/features/auth/domain/entities/login_entity.dart';
import 'package:unigate/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginEntity, LoginParams> {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) {
    return _repository.login(email: params.email, password: params.password);
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };

  @override
  List<Object?> get props => [email, password];
}


