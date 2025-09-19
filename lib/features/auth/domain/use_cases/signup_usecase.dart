import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:unigate/core/errors/failures.dart';
import 'package:unigate/core/usecase/usecase.dart';
import 'package:unigate/features/auth/domain/entities/signup_entity.dart';
import 'package:unigate/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase implements UseCase<SignupEntity, SignupParams> {
  SignupUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<Either<Failure, SignupEntity>> call(SignupParams params) {
    return _repository.signup(
      firstName: params.firstName,
      lastName: params.lastName,
      mobile: params.mobile,
      email: params.email,
      password: params.password,
    );
  }
}

class SignupParams extends Equatable {
  const SignupParams({
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

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'mobile': mobile,
        'email': email,
        'password': password,
      };

  @override
  List<Object?> get props => [firstName, lastName, mobile, email, password];
}


