import 'package:flutter_riverpod/legacy.dart';
import 'package:job_board/controllers/onboarding/onboarding_notifier.dart';
import 'package:job_board/controllers/onboarding/onboarding_state.dart';

final onboardingProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
      return OnboardingNotifier();
    });
