import 'package:app_task/src/domain/database/core/app_database.dart';
import 'package:drift/drift.dart';

part 'user_list_dao.g.dart';

@DriftAccessor(tables: [UserLists])
class UserListDao extends DatabaseAccessor<AppDatabase>
    with _$UserListDaoMixin {
  UserListDao(super.db);

  Future<void> saveUserList(List<UserList> responseList) {
    return batch(
      (batch) => batch.insertAll(
        userLists,
        responseList,
        mode: InsertMode.insertOrReplace,
      ),
    );
  }

  Future<void> deleteAllUserListList() async {
    await delete(userLists).go();
  }

  Future<List<UserList>> getUserListList() async {
    return select(userLists).get();
  }
}

@DataClassName('UserList')
class UserLists extends Table {
  TextColumn get id => text()();

  TextColumn get email => text()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get avatar => text()();

  @override
  Set<Column> get primaryKey => {id};
}
