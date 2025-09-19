// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:unigate/core/constants/environment.dart';

class ListAPI {
  ListAPI._();

  static String get base => Env.baseUrl;

  // ===== Auth
  static String get registerUser => '$base/register';
  static String get loginUser => '$base/login';
  static String get verifyEmail => '$base/verify-email';
  static String get resendCode => '$base/resend-code';
  static String get forgotPassword => '$base/forgot-password';
}
