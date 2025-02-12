import 'package:app_task/src/application/core/base_bloc_event.dart';

class LoginEvent extends BaseBlocEvent {}

class EmailChanged extends LoginEvent {
  String email;
  EmailChanged(this.email);
}

class PasswordChange extends LoginEvent {
  String password;
  PasswordChange(this.password);
}

class LoginButtonTapped extends LoginEvent{}
