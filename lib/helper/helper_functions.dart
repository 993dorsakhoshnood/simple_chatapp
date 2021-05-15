import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  static String sharedPreferenceUserLoggedKey = 'IS LOGGEDIN';
  static String sharedPreferenceUserNameKey = 'USERNAMEKEY';
  static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';

  static Future<bool> saveUserLoggedInSharedPerefrence(
      bool isUserLoggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(
        sharedPreferenceUserLoggedKey, isUserLoggedIn);
  }

  static Future<bool> saveUsernameSharedPerefrence(String username) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, username);
  }

  static Future<bool> saveUserEmailSharedPerefrence(String email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserEmailKey, email);
  }

  static Future<bool> getUserLoggedInSharedPerefrence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getBool(sharedPreferenceUserLoggedKey);
  }

  static Future<String> getUsernameSharedPerefrence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPerefrence() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.getString(sharedPreferenceUserEmailKey);
  }
}
