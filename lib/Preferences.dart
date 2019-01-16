import 'package:quiver/core.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;
import 'package:optional/optional.dart';

class Preferences {
  static final String _kLanguageCode = "language";

  static Future<String> getLanguageCode() async {
    return getValue(_kLanguageCode) ?? "fr";
  }

  static Future<bool> setLanguageCode(String value) async {
    return setValue(_kLanguageCode, value);
  }

  static Future<Optional<String>> getValue(String key) async {
    if (key == null) {
      throw new ArgumentError("key");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return Optional.of(prefs.getString(key));
  }

  static Future<int> getInt(String key) async {
    if (key == null) {
      throw new ArgumentError("key");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key);
  }

  static Future<T> getValueOrDefault<T>(
      String key, T Function() operation) async {
    if (key == null) {
      throw new ArgumentError("key");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    bool exist = prefs.get(key) != null;
    return exist ? prefs.get(key) as T : operation();
  }

  static Future<bool> setValue(String key, String value) async {
    if (key == null) {
      throw new ArgumentError("key");
    }
    if (value == null) {
      throw new ArgumentError("value");
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }

  static Future<bool> setValues(Map<String, String> values) async {    
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var item in values.entries) {
        prefs.setString(item.key, item.value);
    }

    return Future.value(true);    
  }

  static Future<bool> setBool(String key, bool value) async {
    if (key == null) {
      throw new ArgumentError("key");
    }
    if (value == null) {
      throw new ArgumentError("value");
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    if (key == null) {
      throw new ArgumentError("key");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key);
  }

  static void clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    ["Lower", "Upper", "Number", "Size"].forEach((x) => prefs.remove(x));
  }
}
