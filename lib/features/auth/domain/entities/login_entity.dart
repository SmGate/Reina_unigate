import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  const LoginEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    this.gender,
    this.image,
    required this.dob,
    this.currentAddress,
    this.permanentAddress,
    this.occupation,
    required this.status,
    required this.resetRequest,
    this.fcmId,
    this.schoolId,
    required this.language,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.verificationCode,
    required this.verificationExpiresAt,
    required this.fullName,
    required this.schoolNames,
    required this.role,
    this.token,
    this.isVerified,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;
  final String? gender;
  final String? image;
  final String dob;
  final String? currentAddress;
  final String? permanentAddress;
  final String? occupation;
  final int status;
  final int resetRequest;
  final String? fcmId;
  final int? schoolId;
  final String language;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String? deletedAt;
  final String verificationCode;
  final String verificationExpiresAt;
  final String fullName;
  final String schoolNames;
  final String role;
  final String? token;
  final bool? isVerified;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        mobile,
        email,
        gender,
        image,
        dob,
        currentAddress,
        permanentAddress,
        occupation,
        status,
        resetRequest,
        fcmId,
        schoolId,
        language,
        emailVerifiedAt,
        createdAt,
        updatedAt,
        deletedAt,
        verificationCode,
        verificationExpiresAt,
        fullName,
        schoolNames,
        role,
        token,
        isVerified,
      ];
}


