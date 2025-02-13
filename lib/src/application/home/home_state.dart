import 'package:app_task/src/application/core/base_bloc_state.dart';
import 'package:app_task/src/domain/database/core/app_database.dart';

class HomeState extends BaseBlocState {
  List<TaskList?> taskList;
  final bool? deleteTaskStatus;

  HomeState({
    this.taskList = const <TaskList>[],
    this.deleteTaskStatus = false,
  });

  @override
  HomeState copyWith({List<TaskList?>? taskList, bool? deleteTaskStatus}) {
    return HomeState(
      taskList: taskList ?? this.taskList,
      deleteTaskStatus: deleteTaskStatus ?? this.deleteTaskStatus,
    );
  }
}
