import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/appstarter/starter_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarterNotifier extends StateNotifier<StarterState> {
  StarterNotifier() : super(StarterState(seen: false)) {
    _loadOnboardingStatus();
  }

  Future<void> _loadOnboardingStatus() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final seen = pref.getBool('entrypoint') ?? false;
    state = state.copyWith(seen: seen);
  }

  Future<void> completeOnboarding() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('entrypoint', true);
    state = state.copyWith(seen: true);
  }
}
