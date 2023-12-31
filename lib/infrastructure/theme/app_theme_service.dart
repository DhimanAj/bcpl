import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../preference/preference_manager.dart';


class ThemeService {

  // final _box = GetStorage();
  final _key = 'isDarkMode';
  var isCheckMode = false;

  /// Get isDarkMode info from local storage and return ThemeMode
  Future<ThemeMode> get theme async => await loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  Future<bool> loadThemeFromBox() async =>  await PreferenceManager.getBool(_key);

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => PreferenceManager.setBool(_key, isDarkMode);

  /// Switch theme and save to local storage
  Future<void> switchTheme() async {
    Get.changeThemeMode(await loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(await loadThemeFromBox());
  }

}
