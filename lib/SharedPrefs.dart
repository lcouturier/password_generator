import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefs {
  static Future<String> read(String key) async {
    assert(key != null);
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static save(String key, String value) async {
    assert(key != null);
    assert(value != null);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static remove(String key) async {
    assert(key != null);
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
