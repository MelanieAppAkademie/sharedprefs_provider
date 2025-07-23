import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterRepository with ChangeNotifier {
  static const String _counterKey = "current_counter";

  int _counter = 0;

  CounterRepository() {
    _loadCounter();
  }

  int get counter => _counter;

  Future<void> setCurrentCounter(int counter) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt(_counterKey, counter);
    _counter = counter;
    notifyListeners();
  }

  Future<void> _loadCounter() async {
    final _prefs = await SharedPreferences.getInstance();
    _counter = _prefs.getInt(_counterKey) ?? 0;
    notifyListeners();
  }

  void deleteCounter() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(_counterKey);
    _counter = 0;
    notifyListeners();
  }
}
