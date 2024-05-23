abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginLoginError extends LoginState {
  final String message;
  LoginLoginError(this.message);
}

class LoginPasswordError extends LoginState {
  final String message;
  LoginPasswordError(this.message);
}

class LoginFailureState extends LoginState {
  final String message;
  LoginFailureState(this.message);
}

class LoginSuccessState extends LoginState {}
