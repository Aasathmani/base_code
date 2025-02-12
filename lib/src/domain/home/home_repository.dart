import 'package:app_task/src/domain/database/core/app_database.dart';
import 'package:app_task/src/domain/database/task_list_dao.dart';
import 'package:app_task/src/domain/home/home_service.dart';
import 'package:app_task/src/utils/guard.dart';
import 'package:collection/collection.dart';

class HomeRepository {
  static HomeRepository? instance;
  final HomeService homeService;
  final TaskListDao taskListDao;

  HomeRepository({
    required this.homeService,
    required this.taskListDao,
  });

  Future<List<TaskList?>> getTaskList() async {
    await Guard.runAsync(() async {
      final dataFromResponse = await homeService.fetchTaskList();
      if (dataFromResponse.isNotEmpty) {
        final selectProjectList = dataFromResponse
            .map((item) => _taskList(item))
            .whereNotNull()
            .toList();
        await taskListDao.deleteAllTaskListList();

        await taskListDao.saveTaskList(selectProjectList);
      }
    });
    return taskListDao.getTaskListList();
  }

  TaskList? _taskList(Map<String, dynamic> item) {
    return Guard.asNullable<TaskList>(() {
      return TaskList(
        id: item['id'].toString(),
        userId: item['userId'].toString(),
        title: item['title'].toString(),
        completed: item['completed'] as bool,
      );
    });
  }
}
