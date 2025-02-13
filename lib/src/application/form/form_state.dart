import 'package:app_task/src/application/core/base_bloc_state.dart';
import 'package:app_task/src/domain/database/core/app_database.dart';

class FormFillState extends BaseBlocState {
  final String? priorityLevel;
  final String? taskStatus;
  final String? userName;
  final DateTime? dueDate;
  final String? description;
  final String? title;
  final bool? createStatus;
  final List<UserList?> userList;
  final String? userId;

  FormFillState({
    this.priorityLevel,
    this.taskStatus,
    this.userName,
    this.dueDate,
    this.description,
    this.title,
    this.createStatus = false,
    this.userList = const <UserList>[],
    this.userId,
  });
  @override
  FormFillState copyWith({
    String? priorityLevel,
    String? taskStatus,
    String? userName,
    DateTime? dueDate,
    String? description,
    String? title,
    bool? createStatus,
    List<UserList?>? userList,
    String? userId,
  }) {
    return FormFillState(
      priorityLevel: priorityLevel ?? this.priorityLevel,
      taskStatus: taskStatus ?? this.taskStatus,
      userName: userName ?? this.userName,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      title: title ?? this.title,
      createStatus: createStatus ?? this.createStatus,
      userList: userList ?? this.userList,
      userId: userId ?? this.userId,
    );
  }
}
