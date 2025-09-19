import 'package:unigate/features/auth/domain/entities/signup_entity.dart';

class SignupResponseModel extends SignupEntity {
  SignupResponseModel({
    required int id,
    required String firstName,
    required String lastName,
    required String mobile,
    String? gender,
    required String dob,
    required String email,
    required String updatedAt,
    required String createdAt,
    required int verificationCode,
    required String verificationExpiresAt,
    required String fullName,
    required String schoolNames,
    required String role,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          gender: gender,
          dob: dob,
          email: email,
          updatedAt: updatedAt,
          createdAt: createdAt,
          verificationCode: verificationCode,
          verificationExpiresAt: verificationExpiresAt,
          fullName: fullName,
          schoolNames: schoolNames,
          role: role,
        );

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] ?? {}) as Map<String, dynamic>;
    return SignupResponseModel(
      id: (data['id'] ?? 0) as int,
      firstName: (data['first_name'] ?? '') as String,
      lastName: (data['last_name'] ?? '') as String,
      mobile: (data['mobile'] ?? '') as String,
      gender: data['gender'] as String?,
      dob: (data['dob'] ?? '') as String,
      email: (data['email'] ?? '') as String,
      updatedAt: (data['updated_at'] ?? '') as String,
      createdAt: (data['created_at'] ?? '') as String,
      verificationCode: (data['verification_code'] ?? 0) as int,
      verificationExpiresAt: (data['verification_expires_at'] ?? '') as String,
      fullName: (data['full_name'] ?? '') as String,
      schoolNames: (data['school_names'] ?? '') as String,
      role: (data['role'] ?? '') as String,
    );
  }
}


