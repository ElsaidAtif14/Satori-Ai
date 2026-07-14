import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._();

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> removeData(String key) async {
    debugPrint('Remove: $key');
    await _prefs.remove(key);
  }

  static Future<void> clearAllData() async {
    debugPrint('Clear All');
    await _prefs.clear();
  }

  static Future<void> setData(String key, dynamic value) async {
    switch (value) {
      case String _:
        await _prefs.setString(key, value);
        break;
      case int _:
        await _prefs.setInt(key, value);
        break;
      case bool _:
        await _prefs.setBool(key, value);
        break;
      case double _:
        await _prefs.setDouble(key, value);
        break;
    }
  }

  static String getString(String key) => _prefs.getString(key) ?? '';

  static int getInt(String key) => _prefs.getInt(key) ?? 0;

  static bool getBool(String key) => _prefs.getBool(key) ?? false;

  static double getDouble(String key) => _prefs.getDouble(key) ?? 0.0;

  // Flutter Secure Storage
  static const FlutterSecureStorage _secureStorage =
      FlutterSecureStorage();

  static Future<void> setSecuredString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  static Future<String> getSecuredString(String key) async {
    return await _secureStorage.read(key: key) ?? '';
  }

  static Future<void> clearAllSecuredData() async {
    await _secureStorage.deleteAll();
  }
}