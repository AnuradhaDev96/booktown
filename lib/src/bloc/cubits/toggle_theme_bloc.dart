import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../config/preference_keys.dart';
import '../../services/local_store.dart';

class ToggleThemeBloc {
  ToggleThemeBloc() {
    _initializeSavedThemeMode();
  }

  final _themeModeBehaviorSubject = BehaviorSubject<ThemeMode>();

  Stream<ThemeMode> get themeModeStream => _themeModeBehaviorSubject.stream;

  ThemeMode get themeModeValue => _themeModeBehaviorSubject.value;

  /// Change theme using [isDarkMode]. Pass true to enable dark mode.
  void updateTheme({required bool isDarkMode}) async {
    _themeModeBehaviorSubject.sink.add(isDarkMode ? ThemeMode.dark : ThemeMode.light);
    await GetIt.instance<LocalStore>().saveStringValue(
      key: PreferenceKeys.themeMode,
      value: isDarkMode ? ThemeMode.dark.name : ThemeMode.light.name,
    );
  }

  /// initialize theme mode based on saved themeMode
  void _initializeSavedThemeMode() async {
    String currentTheme = await GetIt.instance<LocalStore>().getStringValue(PreferenceKeys.themeMode);
    ThemeMode savedThemeMode =
        (ThemeMode.values.where((theme) => theme.name == currentTheme).firstOrNull) ?? ThemeMode.light;
    updateTheme(isDarkMode: savedThemeMode == ThemeMode.dark);
  }
}
