import 'package:unigate/features/auth/domain/entities/login_entity.dart';

class LoginResponseModel extends LoginEntity {
  LoginResponseModel({
    required int id,
    required String firstName,
    required String lastName,
    required String mobile,
    required String email,
    String? gender,
    String? image,
    required String dob,
    String? currentAddress,
    String? permanentAddress,
    String? occupation,
    required int status,
    required int resetRequest,
    String? fcmId,
    int? schoolId,
    required String language,
    String? emailVerifiedAt,
    required String createdAt,
    required String updatedAt,
    String? deletedAt,
    required String verificationCode,
    required String verificationExpiresAt,
    required String fullName,
    required String schoolNames,
    required String role,
    this.token,
    this.isVerified,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          email: email,
          gender: gender,
          image: image,
          dob: dob,
          currentAddress: currentAddress,
          permanentAddress: permanentAddress,
          occupation: occupation,
          status: status,
          resetRequest: resetRequest,
          fcmId: fcmId,
          schoolId: schoolId,
          language: language,
          emailVerifiedAt: emailVerifiedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
          verificationCode: verificationCode,
          verificationExpiresAt: verificationExpiresAt,
          fullName: fullName,
          schoolNames: schoolNames,
          role: role,
        );

  final String? token;
  final bool? isVerified;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = (json['data'] ?? {}) as Map<String, dynamic>;
    return LoginResponseModel(
      id: (data['id'] ?? 0) as int,
      firstName: (data['first_name'] ?? '') as String,
      lastName: (data['last_name'] ?? '') as String,
      mobile: (data['mobile'] ?? '') as String,
      email: (data['email'] ?? '') as String,
      gender: data['gender'] as String?,
      image: data['image'] as String?,
      dob: (data['dob'] ?? '') as String,
      currentAddress: data['current_address'] as String?,
      permanentAddress: data['permanent_address'] as String?,
      occupation: data['occupation'] as String?,
      status: (data['status'] ?? 0) as int,
      resetRequest: (data['reset_request'] ?? 0) as int,
      fcmId: data['fcm_id'] as String?,
      schoolId: data['school_id'] as int?,
      language: (data['language'] ?? '') as String,
      emailVerifiedAt: data['email_verified_at'] as String?,
      createdAt: (data['created_at'] ?? '') as String,
      updatedAt: (data['updated_at'] ?? '') as String,
      deletedAt: data['deleted_at'] as String?,
      verificationCode: (data['verification_code'] ?? '').toString(),
      verificationExpiresAt:
          (data['verification_expires_at'] ?? '').toString(),
      fullName: (data['full_name'] ?? '') as String,
      schoolNames: (data['school_names'] ?? '') as String,
      role: (data['role'] ?? '') as String,
      token: json['token'] as String?,
      isVerified: (json['is_verified'] ?? data['email_verified_at'] != null)
          as bool?,
    );
  }
}


