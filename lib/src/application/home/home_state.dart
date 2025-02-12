import 'package:app_task/src/application/core/base_bloc_state.dart';
import 'package:app_task/src/domain/database/core/app_database.dart';

class HomeState extends BaseBlocState {
  List<TaskList?> taskList;

  HomeState({
    this.taskList = const <TaskList>[],
  });

  @override
  HomeState copyWith({
    List<TaskList?>? taskList,
  }) {
    return HomeState(taskList: taskList ?? this.taskList);
  }
}
