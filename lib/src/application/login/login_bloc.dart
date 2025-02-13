import 'package:app_task/src/application/core/base_bloc.dart';
import 'package:app_task/src/application/core/process_state.dart';
import 'package:app_task/src/application/login/login_event.dart';
import 'package:app_task/src/application/login/login_state.dart';
import 'package:app_task/src/domain/auth/auth_repository.dart';
import 'package:app_task/src/utils/regex_util.dart';
import 'package:app_task/src/utils/string_utils.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  LoginBloc({
    required this.authRepository,
  }) : super(LoginState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, loginSuccess: false));
    });
    on<PasswordChange>((event, emit) {
      emit(state.copyWith(password: event.password, loginSuccess: false));
    });

    on<LoginButtonTapped>((event, emit) async {
      await _loginButtonTapped(event: event, emit: emit);
    });
  }

  Future<void> _loginButtonTapped({
    required LoginButtonTapped event,
    required Emitter<LoginState> emit,
  }) async {
    if (!_isValid(emit)) {
      return;
    }
    emit(state.copyWith()..processState = ProcessState.busy());

    final result = await authRepository.getLogin(state.email!, state.password!);
    if (result != null) {
      showMessage("Login successfully");
      emit(
        state.copyWith(loginSuccess: true)
          ..processState = ProcessState.completed(),
      );
    } else {
      showMessage("Login failed");
      emit(state.copyWith(loginSuccess: false)
        ..processState = ProcessState.completed());
    }
    emit(state.copyWith()..processState = ProcessState.completed());
  }

  bool _isValid(Emitter<LoginState> emit) {
    bool isValid = true;

    if (StringUtils.isNullOrEmpty(state.email)) {
      showMessage("Email address is empty");
      isValid = false;
    } else if (!RegexUtil.isEmailValid(state.email!)) {
      showMessage("Email is invalid");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.password)) {
      showMessage("Please enter the password");
      isValid = false;
    }

    return isValid;
  }
}
