import 'package:app_task/src/domain/database/base_hive_dao.dart';
import 'package:hive/hive.dart';

class Auth {
  String? id;
  String? token;

  Auth({
    required this.id,
    required this.token,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      id: json['id'].toString(),
      token: json['token'].toString(),
    );
  }
}

class AuthDao extends BaseHiveDao {
  static const kToken = 'token';
  static const kBoxName = "accountBox";

  /// Open Hive Box
  Future<Box> getBox() async {
    return await Hive.openBox(kBoxName);
  }

  /// Save Token
  Future<void> saveToken(String token) async {
    final box = await getBox();
    await box.put(kToken, token);
  }

  /// Retrieve Token
  Future<String?>? getToken() async {
    final box = await getBox();
    final value = await box.get(kToken);
    return value as String?;
  }

  /// Clear Token
  @override
  Future<void> clear() async {
    final box = await getBox();
    await box.clear();
  }
}
