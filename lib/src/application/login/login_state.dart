import 'package:app_task/src/application/core/base_bloc_state.dart';
import 'package:app_task/src/application/core/process_state.dart';

class LoginState extends BaseBlocState {
  String? email;
  String? password;
  bool? loginSuccess;

  LoginState({
    this.password,
    this.email,
    this.loginSuccess = false,
  });

  @override
  LoginState copyWith({
    String? email,
    String? password,
    bool? loginSuccess,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    )..processState = processState;
  }
}
