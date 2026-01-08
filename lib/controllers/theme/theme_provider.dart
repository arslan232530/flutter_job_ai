import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/theme/theme_notifier.dart';
import 'package:job_board/controllers/theme/theme_state.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
