import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unigate/features/auth/data/model/login_response_model.dart';
import 'package:unigate/features/auth/domain/entities/signup_entity.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheLogin(LoginResponseModel model);
  Future<LoginResponseModel?> getCachedLogin();
  Future<void> clearLogin();
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> cacheSignup(SignupEntity entity);
  Future<SignupEntity?> getCachedSignup();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(this._prefs);

  static const String _kLoginKey = 'auth.login.response';
  static const String _kTokenKey = 'auth.token';
  static const String _kSignupKey = 'auth.signup.response';
  final SharedPreferences _prefs;

  @override
  Future<void> cacheLogin(LoginResponseModel model) async {
    final jsonMap = {
      'data': {
        'id': model.id,
        'first_name': model.firstName,
        'last_name': model.lastName,
        'mobile': model.mobile,
        'email': model.email,
        'gender': model.gender,
        'image': model.image,
        'dob': model.dob,
        'current_address': model.currentAddress,
        'permanent_address': model.permanentAddress,
        'occupation': model.occupation,
        'status': model.status,
        'reset_request': model.resetRequest,
        'fcm_id': model.fcmId,
        'school_id': model.schoolId,
        'language': model.language,
        'email_verified_at': model.emailVerifiedAt,
        'created_at': model.createdAt,
        'updated_at': model.updatedAt,
        'deleted_at': model.deletedAt,
        'verification_code': model.verificationCode,
        'verification_expires_at': model.verificationExpiresAt,
        'full_name': model.fullName,
        'school_names': model.schoolNames,
        'role': model.role,
      }
    };
    await _prefs.setString(_kLoginKey, json.encode(jsonMap));
    if (model.token != null && model.token!.isNotEmpty) {
      await saveToken(model.token!);
    }
  }

  @override
  Future<LoginResponseModel?> getCachedLogin() async {
    final str = _prefs.getString(_kLoginKey);
    if (str == null) return null;
    final map = json.decode(str) as Map<String, dynamic>;
    return LoginResponseModel.fromJson(map);
  }

  @override
  Future<void> clearLogin() async {
    await _prefs.remove(_kLoginKey);
    await _prefs.remove(_kTokenKey);
  }

  @override
  Future<void> saveToken(String token) async {
    await _prefs.setString(_kTokenKey, token);
  }

  @override
  String? getToken() {
    return _prefs.getString(_kTokenKey);
  }

  @override
  Future<void> cacheSignup(SignupEntity entity) async {
    final jsonMap = {
      'data': {
        'id': entity.id,
        'first_name': entity.firstName,
        'last_name': entity.lastName,
        'mobile': entity.mobile,
        'gender': entity.gender,
        'dob': entity.dob,
        'email': entity.email,
        'updated_at': entity.updatedAt,
        'created_at': entity.createdAt,
        'verification_code': entity.verificationCode,
        'verification_expires_at': entity.verificationExpiresAt,
        'full_name': entity.fullName,
        'school_names': entity.schoolNames,
        'role': entity.role,
      }
    };
    await _prefs.setString(_kSignupKey, json.encode(jsonMap));
  }

  @override
  Future<SignupEntity?> getCachedSignup() async {
    final str = _prefs.getString(_kSignupKey);
    if (str == null) return null;
    try {
      final map = json.decode(str) as Map<String, dynamic>;
      final data = (map['data'] ?? {}) as Map<String, dynamic>;
      return SignupEntity(
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
        verificationExpiresAt:
            (data['verification_expires_at'] ?? '') as String,
        fullName: (data['full_name'] ?? '') as String,
        schoolNames: (data['school_names'] ?? '') as String,
        role: (data['role'] ?? '') as String,
      );
    } catch (_) {
      return null;
    }
  }
}
