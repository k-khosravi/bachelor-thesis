import 'dart:async' show Future;

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      await SharedPreferences.getInstance();
  static late SharedPreferences _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static String getString(String key, String defaultValue) =>
      _prefsInstance.getString(key) ?? defaultValue;

  static int getInt(String key, int defaultValue) =>
      _prefsInstance.getInt(key) ?? defaultValue;

  static double getDouble(String key, double defaultValue) =>
      _prefsInstance.getDouble(key) ?? defaultValue;

  static setString(String key, String value) async {
    var prefs = await _instance;
    prefs.setString(key, value);
  }

  static setInt(String key, int value) async {
    var prefs = await _instance;
    prefs.setInt(key, value);
  }

  static setDouble(String key, double value) async {
    var prefs = await _instance;
    prefs.setDouble(key, value);
  }
}
