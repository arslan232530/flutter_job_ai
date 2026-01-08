class LoginState {
  final bool loggedIn;
  final String? error;

  const LoginState({this.loggedIn = false, this.error});

  LoginState copyWith({
    bool? isVisible,
    bool? loggedIn,
    String? error,
  }) {
    return LoginState(
      loggedIn: loggedIn ?? this.loggedIn,
      error: error ?? this.error,
    );
  }
}
