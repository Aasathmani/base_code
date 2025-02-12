import 'package:app_task/src/application/core/base_bloc.dart';
import 'package:app_task/src/application/register/register_event.dart';
import 'package:app_task/src/application/register/register_state.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());
}
