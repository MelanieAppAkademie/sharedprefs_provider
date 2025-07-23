import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterRepository with ChangeNotifier {
  Future<void> setCurrentCounter(int counter) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt("current_counter", counter);
    notifyListeners();
  }

  Future<void> setCurrentThemeMode(bool themeMode) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('isDarkMode', themeMode);
    notifyListeners();
  }

  Future<int>? getCurrentCounter() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt("current_counter") ?? 0;
  }

  Future<bool>? getCurrentThemeMode() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool("isDarkMode") ?? false;
  }

  void deleteCounter() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove('current_counter');
    notifyListeners();
  }
}
