import 'package:unigate/features/auth/domain/entities/forgot_password_entity.dart';

class ForgotPasswordResponseModel extends ForgotPasswordEntity {
  ForgotPasswordResponseModel({required String message})
      : super(message: message);

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    final String message = (json['message'] ?? '').toString();
    return ForgotPasswordResponseModel(message: message);
  }
}



