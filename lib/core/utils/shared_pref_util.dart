import 'dart:convert';

import 'package:footsapp/core/di/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  final prefs = sl<SharedPreferences>();

  readObject(String key) {
    return json.decode(prefs.getString(key));
  }

  readString(String key) {
    return prefs.getString(key);
  }

  readInt(String key) {
    return prefs.getInt(key);
  }

  readBool(String key) {
    return prefs.getBool(key);
  }

  readDouble(String key) {
    return prefs.getDouble(key);
  }

  saveObject(String key, value) {
    prefs.setString(key, json.encode(value));
  }

  saveString(String key, value) {
    prefs.setString(key, value);
  }

  saveInt(String key, value) {
    prefs.setInt(key, value);
  }

  saveBool(String key, value) {
    prefs.setBool(key, value);
  }

  saveDouble(String key, value) {
    prefs.setDouble(key, value);
  }

  Future<void> remove(String key) async {
    await prefs.remove(key);
  }
}
