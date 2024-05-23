class LoginException implements Exception {
  final String message;
  LoginException(this.message);
}

class PasswordException implements Exception {
  final String message;
  PasswordException(this.message);
}