import 'dart:convert';

import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  ///! use singleton pattern to ensure only one instance of SharedPreferences is created
  static final SharedPref _instance = SharedPref._internal();
  SharedPref._internal();
  static late SharedPreferences _prefs;

  factory SharedPref() {
    return _instance;
  }
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///! set userToken
  static const String userTokenKey = 'userToken';
  static const String userInfoKey = 'userInfo';

  ///! save userToken to shared preferences
  static Future<void> setUserInfo(User userInfo) async {
    var userInfoJson = userInfo.toJson();
    // String jsonToString = json.encode(userInfoJson);
    // or
    // use jsonEncode from dart:convert
    String jsonToString = jsonEncode(userInfoJson);
    setString(userInfoKey, jsonToString);
  }

  ///! get userInfo from shared preferences
  static User? getUserInfo() {
    var cacheUserInfoJson = getString(userInfoKey);
    if (cacheUserInfoJson == null || cacheUserInfoJson.isEmpty) return null;
    var stringToJson = json.decode(cacheUserInfoJson);
    // or
    // use jsonDecode from dart:convert
    // var stringToJson = jsonDecode(cacheUserInfoJson!);
    var jsonToModel = User.fromJson(stringToJson);
    return jsonToModel;
  }

  ///! remove userInfo from shared preferences
  static Future<void> removeUserInfo() async {
    await removeData(userInfoKey);
    await removeData(userTokenKey);
    debugPrint('User info and token removed from shared preferences');
  }

  ///! save userToken to shared preferences
  static Future<void> setUserToken(String token) async {
    debugPrint('Saving token: $token');
    await _prefs.setString(userTokenKey, token);
    // Verify it was saved
    final saved = _prefs.getString(userTokenKey);
    debugPrint('Token saved verification: $saved');
  }

  ///! get userToken
  static String? getUserToken() {
    return _prefs.getString(userTokenKey);
  }

  ///! save data to shared preferences
  // Future<bool> saveData(String key, dynamic value) async {
  //   if (value is String) {
  //     return await _prefs.setString(key, value);
  //   } else if (value is int) {
  //     return await _prefs.setInt(key, value);
  //   } else if (value is double) {
  //     return await _prefs.setDouble(key, value);
  //   } else if (value is bool) {
  //     return await _prefs.setBool(key, value);
  //   } else if (value is List<String>) {
  //     return await _prefs.setStringList(key, value);
  //   }
  //   return false;
  // }
  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  static Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  static Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  ///! get data from shared preferences
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  static double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  ///! remove data from shared preferences
  static Future<void> removeData(String key) async {
    await _prefs.remove(key);
  }
}
