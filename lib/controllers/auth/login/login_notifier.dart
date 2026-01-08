import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/auth/login/login_state.dart';
import 'package:job_board/models/request/auth/login_model.dart';
import 'package:job_board/models/request/auth/profile_update_model.dart';
import 'package:job_board/services/helpers/auth_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginResult { success, failure }

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(const LoginState()) {
    _loadLoggedInStatus();
  }

  Future<void> _loadLoggedInStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final loggedIn = pref.getBool('jobloggedin') ?? false;
    state = state.copyWith(loggedIn: loggedIn);
  }

  Future<void> loggedInSuccess() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('jobloggedin', true);
    state = state.copyWith(loggedIn: true);
  }

  Future<LoginResult> userLogin(LoginModel model) async {
    state = state.copyWith(error: null);

    final errorMessage = await AuthHelper.login(model);

    if (errorMessage != null) {
      state = state.copyWith(error: errorMessage);
      return LoginResult.failure;
    }

    await loggedInSuccess();
    return LoginResult.success;
  }

  void logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('jobloggedin');
    await pref.setBool('jobloggedin', false);
  }

  Future<bool> updateProfile(
    ProfileUpdateReq model, {
    File? imageFile,
  }) async {
    return await AuthHelper.updateProfile(model, imageFile: imageFile);
  }
}
