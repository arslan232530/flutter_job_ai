import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/auth/login/login_notifier.dart';
import 'package:job_board/controllers/auth/login/login_state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((
  ref,
) {
  return LoginNotifier();
});
