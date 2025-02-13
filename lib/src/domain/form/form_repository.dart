import 'package:app_task/src/domain/database/core/app_database.dart';
import 'package:app_task/src/domain/database/user_list_dao.dart';
import 'package:app_task/src/domain/form/form_service.dart';
import 'package:app_task/src/utils/guard.dart';
import 'package:collection/collection.dart';

class FormRepository {
  static FormRepository? instance;
  final FormService formService;
  final UserListDao userListDao;

  FormRepository({
    required this.formService,
    required this.userListDao,
  });

  Future<bool>? getCreateTask(Map<String, dynamic> responseData) async {
    try {
      final dataFromResponse =
          await formService.fetchGetCreatTask(responseData);
      return dataFromResponse;
    } catch (e) {
      rethrow;
    }
  }


  Future<bool>? getUpdateTask(Map<String, dynamic> responseData,int id) async {
    try {
      final dataFromResponse =
      await formService.fetchUpdateTask(responseData,id);
      return dataFromResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserList?>?> getUserList() async {
    await Guard.runAsync(() async {
      final dataFromResponse = await formService.fetchTaskList();
      if (dataFromResponse.isNotEmpty) {
        final selectProjectList = dataFromResponse
            .map((item) => _userList(item))
            .whereNotNull()
            .toList();
        await userListDao.deleteAllUserListList();

        await userListDao.saveUserList(selectProjectList);
      }
    });
    return userListDao.getUserListList();
  }

  UserList? _userList(Map<String, dynamic> item) {
    return Guard.asNullable<UserList>(() {
      return UserList(
        id: item["id"].toString(),
        email: item['email'].toString(),
        firstName: item['first_name'].toString(),
        lastName: item['last_name'].toString(),
        avatar: item['avatar'].toString(),
      );
    });
  }
}
