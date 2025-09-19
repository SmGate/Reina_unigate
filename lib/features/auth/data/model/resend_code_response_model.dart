import 'package:unigate/features/auth/domain/entities/resend_code_entity.dart';

class ResendCodeResponseModel extends ResendCodeEntity {
  ResendCodeResponseModel({required String message}) : super(message: message);

  factory ResendCodeResponseModel.fromJson(Map<String, dynamic> json) {
    final String message = (json['message'] ?? '').toString();
    return ResendCodeResponseModel(message: message);
  }
}


