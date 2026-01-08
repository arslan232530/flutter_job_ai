class PasswordService {
  static bool isStrong(String password) {
    if (password.isEmpty) return false;

    final RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );

    return regex.hasMatch(password);
  }
}
