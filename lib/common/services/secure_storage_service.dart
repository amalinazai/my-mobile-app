// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Used to persist data that needs to be stored securely.
/// e.g. user token for API calls
class SecureStorageService {
//============================================================
// ** Properties **
//============================================================

  factory SecureStorageService() => instance;

  SecureStorageService._();

  static final SecureStorageService instance = SecureStorageService._();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AndroidOptions _androidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

//============================================================
// ** Basic Functions **
//============================================================

  Future<void> write(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
      aOptions: _androidOptions(),
    );
    log('[Stored secure data]: \nKey: $key \nValue: $value');
  }

  Future<String?> read(String key) async {
    final readData = await _storage.read(
      key: key,
      aOptions: _androidOptions(),
    );
    log('[Read secure data]: \nKey: $key \nValue: ${readData ?? "null"}');
    return readData;
  }

  Future<void> delete(String key) async {
    await _storage.delete(
      key: key,
      aOptions: _androidOptions(),
    );
    log('[Deleted secure data]: \nKey: $key');
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll(
      aOptions: _androidOptions(),
    );
    log('Deleted all secure data!');
  }
}
