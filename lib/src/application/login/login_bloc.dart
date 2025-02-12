import 'package:app_task/src/application/core/base_bloc.dart';
import 'package:app_task/src/application/core/process_state.dart';
import 'package:app_task/src/application/login/login_event.dart';
import 'package:app_task/src/application/login/login_state.dart';
import 'package:app_task/src/domain/auth/auth_repository.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({
    required this.authRepository,
  }) : super(LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<PasswordChange>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginButtonTapped>((event, emit) async {
      await _loginButtonTapped(event: event, emit: emit);
    });
  }

  Future<void> _loginButtonTapped({
    required LoginButtonTapped event,
    required Emitter<LoginState> emit,
  }) async {
    emit(state.copyWith()..processState = ProcessState.busy());

    final result = await authRepository.getLogin(state.email!, state.password!);
    if (result != null) {
      emit(
        state.copyWith(loginSuccess: true)
          ..processState = ProcessState.completed(),
      );
    } else {
      showMessage("Login failed");
      emit(state.copyWith(loginSuccess: true)..processState = ProcessState.completed());
    }
  }
}
