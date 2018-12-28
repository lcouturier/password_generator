
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  static final String _kLanguageCode = "language";

  static Future<String> getLanguageCode() async {    
    return getValue(_kLanguageCode) ?? "fr";
  }

  static Future<bool> setLanguageCode(String value) async {
    return setValue(_kLanguageCode, value);
  }

  static Future<String> getValue(String key) async {
  if (key == null){
      throw new ArgumentError("key");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? null;
  }

  static Future<bool> setValue(String key, String value) async {
    if (key == null){
      throw new ArgumentError("key");
    }
    if (value == null){
      throw new ArgumentError("value");
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(key, value);
  }
}
