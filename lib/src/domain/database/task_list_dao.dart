import 'package:app_task/src/domain/database/core/app_database.dart';
import 'package:drift/drift.dart';

part 'task_list_dao.g.dart';

@DriftAccessor(tables: [TaskLists])
class TaskListDao extends DatabaseAccessor<AppDatabase>
    with _$TaskListDaoMixin {
  TaskListDao(super.db);

  Future<void> saveTaskList(List<TaskList> taskList) {
    return batch(
      (batch) => batch.insertAll(
        taskLists,
        taskList,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  Future<void> deleteAllTaskListList() async {
    await delete(taskLists).go();
  }

  Future<List<TaskList>> getTaskListList() async {
    return select(taskLists).get();
  }
}

@DataClassName('TaskList')
class TaskLists extends Table {
  TextColumn get id => text()();

  TextColumn get userId => text()();
  TextColumn get title => text()();
  BoolColumn get completed => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
