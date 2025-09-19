import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  AppPrefs(this._prefs);

  final SharedPreferences _prefs;

  static const String _kOnboardingSeen = 'app.onboarding.seen';
  static const String _kProfileSetupCompleted = 'app.profile.completed';
  static const String _kProfileSetupData = 'app.profile.data';
  static const String _kGuest = 'app.guest.mode';

  bool get hasSeenOnboarding => _prefs.getBool(_kOnboardingSeen) ?? false;
  bool get hasCompletedProfileSetup =>
      _prefs.getBool(_kProfileSetupCompleted) ?? false;
  bool get isGuest => _prefs.getBool(_kGuest) ?? false;

  Future<void> setOnboardingSeen(bool value) async {
    await _prefs.setBool(_kOnboardingSeen, value);
  }

  Future<void> setProfileSetupCompleted(bool value) async {
    await _prefs.setBool(_kProfileSetupCompleted, value);
  }

  Future<void> setGuest(bool value) async {
    await _prefs.setBool(_kGuest, value);
  }

  Future<void> saveProfileSetup({
    required int educationLevelIndex,
    required List<String> selectedCourses,
    required List<String> selectedCities,
  }) async {
    final map = {
      'education_level_index': educationLevelIndex,
      'courses': selectedCourses,
      'cities': selectedCities,
    };
    await _prefs.setString(_kProfileSetupData, json.encode(map));
  }

  Map<String, dynamic>? getProfileSetup() {
    final str = _prefs.getString(_kProfileSetupData);
    if (str == null) return null;
    try {
      return json.decode(str) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}


