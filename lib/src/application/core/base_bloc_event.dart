
import 'package:app_task/src/application/core/process_state.dart';

abstract class BaseBlocEvent {
  ProcessState processState = ProcessState.initial();
}
