import 'package:shared_preferences/shared_preferences.dart';

/// shared preference storage
class Prefs {
  SharedPreferences _sharedPreferences;

  static const String _APP_LANGUAGE_CODE = "app_language_code";
  static const String _APP_COUNTRY_CODE = "app_country_code";

  Prefs();

  set sharedPreferences(SharedPreferences value) {
    _sharedPreferences = value;
  }

  /// for clearing the data in preference
  void clearPrefs() {
    _sharedPreferences.clear();
  }

  String get getLanguageCode =>
      _sharedPreferences.getString(_APP_LANGUAGE_CODE) ?? 'en';

  set setLanguageCode(String languageCode) {
    _sharedPreferences.setString(_APP_LANGUAGE_CODE, languageCode);
  }

  String get getCountryCode =>
      _sharedPreferences.getString(_APP_COUNTRY_CODE) ?? 'US';

  set setCountryCode(String countryCode) {
    _sharedPreferences.setString(_APP_COUNTRY_CODE, countryCode);
  }
}
