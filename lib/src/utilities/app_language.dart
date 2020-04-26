import 'package:flutter/material.dart';
import 'package:gismachinetest/src/managers/object_factory.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale("en");

  fetchLocale() async {
    _appLocale = Locale(ObjectFactory().prefs.getLanguageCode);
    return Null;
  }

  void changeLanguage(Locale type) async {
    if (_appLocale == type) {
      return;
    }
    if (type == Locale("ar")) {
      _appLocale = Locale("ar");
      ObjectFactory().prefs.setLanguageCode = 'ar';
      ObjectFactory().prefs.setCountryCode = '';
    } else {
      _appLocale = Locale("en");
      ObjectFactory().prefs.setLanguageCode = 'en';
      ObjectFactory().prefs.setCountryCode = 'US';
    }
    notifyListeners();
  }
}
