import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<LocalStorage?> getInstance() async {
    if (_storageUtil == null) {
      // keep local instance till it is fully initialized.
      var secureStorage = LocalStorage._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil;
  }

  LocalStorage._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /* SHARED PREFERENCECS */

  // get value
  static readSP(String key, {String defValue = ''}) {
    if (_preferences == null) return defValue;
    String val = _preferences!.getString(key) ?? '';
    try {
      return json.decode(val);
    } catch (e) {
      return val;
    }
  }

  // get value
  static hasSP(String key) {
    if (_preferences == null) return false;
    return _preferences!.getString(key) != null &&
        _preferences!.getString(key)!.length > 1;
  }

  // set value
  static saveSP(String key, value) {
    if (_preferences == null) return null;
    return _preferences!.setString(key, json.encode(value));
  }

  // delete value
  static removeSP(String key) async {
    if (_preferences == null) return null;
    _preferences!.remove(key);
  }
}
