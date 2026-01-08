import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/theme/theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier() : super(const ThemeState(themeMode: ThemeMode.system));

  void setLightTheme() {
    state = state.copyWith(themeMode: ThemeMode.light);
  }

  void setDarkTheme() {
    state = state.copyWith(themeMode: ThemeMode.dark);
  }

  void setSystemTheme() {
    state = state.copyWith(themeMode: ThemeMode.system);
  }

  void toggleTheme() {
    if (state.themeMode == ThemeMode.light) {
      setDarkTheme();
    } else {
      setLightTheme();
    }
  }
}
