import 'package:gismachinetest/src/managers/prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObjectFactory {
  static final _objectFactory = ObjectFactory._internal();

  ObjectFactory._internal();

  factory ObjectFactory() => _objectFactory;

  ///Initialisation of Objects
  Prefs _prefs = Prefs();

  ///
  /// Getter Objects
  ///

  Prefs get prefs => _prefs;

  ///
  /// Setter Objects
  ///

  void setPrefs(SharedPreferences value) {
    _prefs.sharedPreferences = value;
  }
}
