abstract class LoginResult {
  final String message;
  LoginResult({required this.message});
}

class LoginSuccess extends LoginResult {
  LoginSuccess(): super(message: '');
}

class LoginEmailFail extends LoginResult {
  LoginEmailFail(String message): super(message: message);
}

class LoginPasswordFail extends LoginResult {
  LoginPasswordFail(String message): super(message: message);
}

class LoginFail extends LoginResult {
  LoginFail(String message): super(message: message);
}