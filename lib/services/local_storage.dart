import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements ILocalStorage {
  final SharedPreferencesAsync _sharedPrefs = SharedPreferencesAsync();

  @override
  Future<void> deleteKey(LocalStorageKeys key) async {
    await _sharedPrefs.remove(key.toString());
  }

  @override
  Future<String?> getString(LocalStorageKeys key) async {
    return await _sharedPrefs.getString(key.toString());
  }

  @override
  Future<void> writeSting(LocalStorageKeys key, String value) async {
    await _sharedPrefs.setString(key.toString(), value);
  }

  @override
  Future<bool?> getBool(LocalStorageKeys key) async {
    return await _sharedPrefs.getBool(key.toString());
  }

  @override
  Future<void> writeBool(LocalStorageKeys key, bool value) async {
    await _sharedPrefs.setBool(key.toString(), value);
  }

}

abstract class ILocalStorage {
  Future<String?> getString(LocalStorageKeys key);
  Future<void> writeSting(LocalStorageKeys key, String value);
  Future<bool?> getBool(LocalStorageKeys key);
  Future<void> writeBool(LocalStorageKeys key, bool value);
  Future<void> deleteKey(LocalStorageKeys key);
}

enum LocalStorageKeys {
  strThemeName,
  boolThemeIsLight
}