import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/auth/signup/signup_notifier.dart';
import 'package:job_board/controllers/auth/signup/signup_state.dart';

final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((
  ref,
) {
  return SignupNotifier();
});
