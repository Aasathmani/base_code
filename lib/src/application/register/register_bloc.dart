import 'package:app_task/src/application/core/base_bloc.dart';
import 'package:app_task/src/application/core/process_state.dart';
import 'package:app_task/src/application/register/register_event.dart';
import 'package:app_task/src/application/register/register_state.dart';
import 'package:app_task/src/domain/auth/auth_repository.dart';
import 'package:app_task/src/utils/regex_util.dart';
import 'package:app_task/src/utils/string_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  RegisterBloc({
    required this.authRepository,
  }) : super(RegisterState()) {
    on<NameChanged>((event, emit) {
      emit(state.copyWith(name: event.name, registerSuccess: false));
    });
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, registerSuccess: false));
    });
    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, registerSuccess: false));
    });
    on<RegisterTapped>((event, emit) async {
      await _registerTapped(event: event, emit: emit);
    });
  }

  Future<void> _registerTapped({
    required RegisterTapped event,
    required Emitter<RegisterState> emit,
  }) async {
    if (!_isValid(emit)) {
      return;
    }
    emit(state.copyWith()..processState = ProcessState.busy());

    final result =
        await authRepository.getRegister(state.email!, state.password!);
    if (result != null) {
      showMessage("Successfully register");
      emit(
        state.copyWith(registerSuccess: true)
          ..processState = ProcessState.completed(),
      );
    } else {
      showMessage("Login failed");
      emit(state.copyWith(registerSuccess: false)
        ..processState = ProcessState.completed());
    }
    emit(state.copyWith(registerSuccess: false)
      ..processState = ProcessState.completed());
  }

  bool _isValid(Emitter<RegisterState> emit) {
    bool isValid = true;
    if (StringUtils.isNullOrEmpty(state.name)) {
      showMessage("Please enter the name");
      isValid = false;
    } else if (StringUtils.isNullOrEmpty(state.email)) {
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
