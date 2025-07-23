import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  ThemeProvider() {
    _loadThemePreference();
  }

  bool get isDarkMode => _isDarkMode;

  Future<void> setCurrentThemeMode(bool themeMode) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('isDarkMode', themeMode);
    _isDarkMode = themeMode;
    notifyListeners();
  }

  Future<void> _loadThemePreference() async {
    final _prefs = await SharedPreferences.getInstance();
    _isDarkMode = _prefs.getBool("isDarkMode") ?? false;
    notifyListeners();
  }
}
