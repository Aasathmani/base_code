import 'package:app_task/src/application/core/base_bloc_event.dart';

class FormFillEvent extends BaseBlocEvent {}

class SelectedDate extends FormFillEvent {
  DateTime? dateTime;
  SelectedDate(this.dateTime);
}

class PriorityChange extends FormFillEvent {
  String? value;
  PriorityChange(this.value);
}
