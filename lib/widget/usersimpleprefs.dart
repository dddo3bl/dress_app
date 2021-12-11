

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePrefrences{

  static SharedPreferences _preferences;
  static const _KeyUsername = "username";
  static const _KeyEmail = "email";
  static const _Keyphone = "phone";
  static const _Keypassword = "password";
  static const _KeyuserId = "user_id";


  static Future init() async => _preferences = await SharedPreferences.getInstance();
  static Future setUsername(String username) async => await _preferences.setString(_KeyUsername, username);
  static String getUsername() => _preferences.getString(_KeyUsername);
  static Future setEmail(String email) async => await _preferences.setString(_KeyEmail, email);
  static String getEmail() => _preferences.getString(_KeyEmail);
  static Future setPhone(String phone) async => await _preferences.setString(_Keyphone, phone);
  static String getphone() => _preferences.getString(_Keyphone);
  static Future setPassword(String password) async => await _preferences.setString(_Keypassword, password);
  static String getPassword() => _preferences.getString(_Keypassword);
  static Future setId(String id) async => await _preferences.setString(_KeyuserId, id);
  static String getId() => _preferences.getString(_KeyuserId);
  static Future remove() => _preferences.clear();
  
  
}