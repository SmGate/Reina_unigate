import 'package:equatable/equatable.dart';

class SignupEntity extends Equatable {
  const SignupEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    this.gender,
    required this.dob,
    required this.email,
    required this.updatedAt,
    required this.createdAt,
    required this.verificationCode,
    required this.verificationExpiresAt,
    required this.fullName,
    required this.schoolNames,
    required this.role,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String? gender;
  final String dob;
  final String email;
  final String updatedAt;
  final String createdAt;
  final int verificationCode;
  final String verificationExpiresAt;
  final String fullName;
  final String schoolNames;
  final String role;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        mobile,
        gender,
        dob,
        email,
        updatedAt,
        createdAt,
        verificationCode,
        verificationExpiresAt,
        fullName,
        schoolNames,
        role,
      ];
}


