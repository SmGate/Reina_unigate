import 'package:unigate/features/auth/domain/entities/verify_email_entity.dart';

class VerifyEmailResponseModel extends VerifyEmailEntity {
  VerifyEmailResponseModel({required String message}) : super(message: message);

  factory VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) {
    final String message = (json['message'] ?? '').toString();
    return VerifyEmailResponseModel(message: message);
  }
}


