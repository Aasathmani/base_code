import 'package:app_task/src/application/core/base_bloc_state.dart';

class RegisterState extends BaseBlocState {
  String? name;
  String? email;
  String? password;
  bool? registerSuccess;

  RegisterState({
    this.password,
    this.email,
    this.name,
    this.registerSuccess = false,
  });

  @override
  RegisterState copyWith({
    String? name,
    String? password,
    String? email,
    bool? registerSuccess,
  }) {
    return RegisterState(
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      registerSuccess: registerSuccess ?? this.registerSuccess,
    );
  }
}
