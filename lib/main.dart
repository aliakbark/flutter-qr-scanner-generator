import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gismachinetest/src/app.dart';
import 'package:gismachinetest/src/managers/object_factory.dart';
import 'package:gismachinetest/src/utilities/app_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///setting pref
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ObjectFactory().setPrefs(sharedPreferences);

  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();

  runApp(MyApp(appLanguage: appLanguage));
}
