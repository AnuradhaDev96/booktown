import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ToggleThemeBloc {
  ToggleThemeBloc() {
    updateTheme(isDarkMode: false);
  }
  final _themeModeBehaviorSubject = BehaviorSubject<ThemeMode>();

  Stream<ThemeMode> get themeModeStream => _themeModeBehaviorSubject.stream;

  ThemeMode get themeModeValue => _themeModeBehaviorSubject.value;

  /// Change theme using [isDarkMode]. Pass true to enable dark mode.
  void updateTheme({required bool isDarkMode}) {
    _themeModeBehaviorSubject.sink.add(isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }
}
