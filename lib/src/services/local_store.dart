import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {

  /// save string value
  Future<void> saveStringValue({required String key, required String value}) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
  }

  /// get string value
  Future<String> getStringValue(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  /// save bool value
  Future<void> saveBoolValue(String key, bool value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
  }

  /// get bool value
  Future<bool> getBoolValue(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  /// save int value
  Future<void> saveIntValue(String key, int value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
  }

  /// get int value
  Future<int> getIntValue(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? -1;
  }

  /// remove value
  Future<bool> removeValue(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }
}