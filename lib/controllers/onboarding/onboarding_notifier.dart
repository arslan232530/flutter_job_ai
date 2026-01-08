import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/onboarding/onboarding_state.dart';

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  void onPageChanged(int page) {
    state = state.copyWith(isLastPage: page == 2);
  }
}
