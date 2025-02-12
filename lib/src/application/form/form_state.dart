import 'package:app_task/src/application/core/base_bloc_state.dart';

class FormFillState extends BaseBlocState {
  final String? priorityLevel;

  FormFillState({
    this.priorityLevel,
  });
  @override
  FormFillState copyWith({
    String? priorityLevel,
  }) {
    return FormFillState(
      priorityLevel: priorityLevel ?? this.priorityLevel,
    );
  }
}
