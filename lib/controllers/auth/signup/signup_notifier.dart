import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/auth/signup/signup_state.dart';
import 'package:job_board/models/request/auth/signup_model.dart';
import 'package:job_board/services/helpers/auth_helper.dart';

enum SignupResult { success, failure }

class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier() : super(const SignupState());

  Future<SignupResult> signupUser(SignupModel model) async {
    state = state.copyWith(isLoading: true, error: null);

    final errorMessage = await AuthHelper.signup(model);

    if (errorMessage != null) {
      state = state.copyWith(isLoading: false, error: errorMessage);
      return SignupResult.failure;
    }

    state = state.copyWith(isLoading: false);
    return SignupResult.success;
  }
}
