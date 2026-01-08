class SignupState {
  final bool isLoading;
  final String? error;

  const SignupState({
    this.isLoading = false,
    this.error,
  });

  SignupState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
