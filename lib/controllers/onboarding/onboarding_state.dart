class OnboardingState {
  final bool isLastPage;

  const OnboardingState({this.isLastPage = false});

  OnboardingState copyWith({bool? isLastPage}) {
    return OnboardingState(isLastPage: isLastPage ?? this.isLastPage);
  }
}
