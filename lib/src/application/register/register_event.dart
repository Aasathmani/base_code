import 'package:app_task/src/application/core/base_bloc_event.dart';

class RegisterEvent extends BaseBlocEvent {}

class NameChanged extends RegisterEvent {
  String? name;
  NameChanged(this.name);
}

class EmailChanged extends RegisterEvent {
  String? email;
  EmailChanged(this.email);
}

class PasswordChanged extends RegisterEvent {
  String? password;
  PasswordChanged(this.password);
}

class RegisterTapped extends RegisterEvent{

}
