import 'package:app_task/src/application/core/base_bloc_event.dart';

class FormFillEvent extends BaseBlocEvent {}

class Initialize extends FormFillEvent {}

class SelectedDate extends FormFillEvent {
  DateTime? dateTime;
  SelectedDate(this.dateTime);
}

class PriorityChange extends FormFillEvent {
  String? value;
  PriorityChange(this.value);
}

class TaskStatus extends FormFillEvent {
  String? status;
  TaskStatus(this.status);
}

class AssignedUser extends FormFillEvent {
  String? userId;
  String? userName;
  AssignedUser({this.userId, this.userName});
}

class DescriptionChanged extends FormFillEvent {
  String? description;
  DescriptionChanged(this.description);
}

class TitleChanged extends FormFillEvent {
  String? title;
  TitleChanged(this.title);
}

class CreateTaskTapped extends FormFillEvent {}
