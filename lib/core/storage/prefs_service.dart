import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class PrefsService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  static String? getString(String key) => _prefs?.getString(key);

  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  static bool getBool(String key, {bool defaultValue = false}) =>
      _prefs?.getBool(key) ?? defaultValue;

  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  static int getInt(String key, {int defaultValue = 0}) =>
      _prefs?.getInt(key) ?? defaultValue;

  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  static Future<void> clear() async {
    await _prefs?.clear();
  }

  static String? getLanguage() => getString(PreferencesKeys.language);
  static Future<void> setLanguage(String language) async =>
      setString(PreferencesKeys.language, language);

  static String? getDistanceUnit() => getString(PreferencesKeys.distanceUnit);
  static Future<void> setDistanceUnit(String unit) async =>
      setString(PreferencesKeys.distanceUnit, unit);

  static String? getCurrency() => getString(PreferencesKeys.currency);
  static Future<void> setCurrency(String currency) async =>
      setString(PreferencesKeys.currency, currency);

  static bool isFirstLaunch() =>
      getBool(PreferencesKeys.firstLaunch, defaultValue: true);
  static Future<void> setFirstLaunchDone() async =>
      setBool(PreferencesKeys.firstLaunch, false);

  static String? getThemeName() => getString(PreferencesKeys.themeMode);
  static Future<void> setThemeName(String name) async =>
      setString(PreferencesKeys.themeMode, name);
}
