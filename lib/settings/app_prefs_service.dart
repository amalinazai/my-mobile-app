import 'dart:developer';

import 'package:my_mobile_app/settings/debug_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefsService {
//============================================================
// ** Properties **
//============================================================

  factory AppPrefsService() => instance;

  AppPrefsService._();

  static final AppPrefsService instance = AppPrefsService._();

  static late SharedPreferences _sharedPreferences;

  Future<AppPrefsService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();

    return instance;
  }

//============================================================
// ** Functions - Get **
//============================================================

  int? getInt(String key) {
    final value = _sharedPreferences.getInt(key);
    if (logAppPrefs) {
      log('[AppPrefsService] get {$key}: $value (int)');
    }

    return value;
  }

  bool? getBool(String key) {
    final value = _sharedPreferences.getBool(key);
    if (logAppPrefs) {
      log('[AppPrefsService] get {$key}: $value (bool)');
    }

    return value;
  }

  double? getDouble(String key) {
    final value = _sharedPreferences.getDouble(key);
    if (logAppPrefs) {
      log('[AppPrefsService] get {$key}: $value (double)');
    }

    return value;
  }

  String? getString(String key) {
    final value = _sharedPreferences.getString(key);
    if (logAppPrefs) {
      log('[AppPrefsService] get {$key}: $value (String)');
    }

    return value;
  }

  List<String>? getStringList(String key) {
    final value = _sharedPreferences.getStringList(key);
    if (logAppPrefs) {
      log('[AppPrefsService] get {$key}: $value (List<String>)');
    }

    return value;
  }

//============================================================
// ** Functions - Set **
//============================================================

  Future<void> setInt(
    String key, {
    required int value,
  }) async {
    try {
      await _sharedPreferences.setInt(key, value);
      if (logAppPrefs) {
        log('[AppPrefsService] set {$key}: $value (int)');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setBool(
    String key, {
    required bool value,
  }) async {
    try {
      await _sharedPreferences.setBool(key, value);
      if (logAppPrefs) {
        log('[AppPrefsService] set {$key}: $value (bool)');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setDouble(
    String key, {
    required double value,
  }) async {
    try {
      await _sharedPreferences.setDouble(key, value);
      if (logAppPrefs) {
        log('[AppPrefsService] set {$key}: $value (double)');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setString(
    String key, {
    required String value,
  }) async {
    try {
      await _sharedPreferences.setString(key, value);
      if (logAppPrefs) {
        log('[AppPrefsService] set {$key}: $value (String)');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setStringList(
    String key, {
    required List<String> value,
  }) async {
    try {
      await _sharedPreferences.setStringList(key, value);
      if (logAppPrefs) {
        log('[AppPrefsService] set {$key}: $value (List<String>)');
      }
    } catch (e) {
      rethrow;
    }
  }

//============================================================
// ** Functions - Remove **
//============================================================

  Future<void> remove(String key) async {
    try {
      await _sharedPreferences.remove(key);
      if (logAppPrefs) {
        log('[AppPrefsService] Removed {$key}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearAll() async {
  try {
    await _sharedPreferences.clear();
    if (logAppPrefs) {
      log('[AppPrefsService] Cleared all data');
    }
  } catch (e) {
    rethrow;
  }
}
}
