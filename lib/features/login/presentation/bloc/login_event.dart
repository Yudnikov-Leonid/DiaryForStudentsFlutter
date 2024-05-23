abstract class LoginEvent {}

class LoginHideErrorsEvent extends LoginEvent {}

class LoginLoginEvent extends LoginEvent {
  final String login, password;

  LoginLoginEvent(this.login, this.password);
}
