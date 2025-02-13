import 'dart:convert';

import 'package:app_task/src/core/exceptions.dart';
import 'package:http/http.dart' as http;

class FormService {
  Future<bool> fetchGetCreatTask(Map<String, dynamic> responseData) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos');

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(responseData),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> fetchUpdateTask(
    Map<String, dynamic> responseData,
    int id,
  ) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/$id');

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(responseData),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> fetchTaskList() async {
    try {
      var url = Uri.parse("https://reqres.in/api/users");
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData =
            jsonDecode(response.body) as Map<String, dynamic>;
        if (!jsonData.containsKey("data") || jsonData["data"] is! List) {
          throw APIValidationFailException(
            message: "Invalid response format: Missing 'data' key",
          );
        }

        final List<dynamic> userList =
            jsonData["data"] as List<dynamic>; // Extract the user list
        return userList.map((e) => e as Map<String, dynamic>).toList();
      } else {
        throw APIValidationFailException(
          message: "Failed to fetch tasks. Status Code: ${response.statusCode}",
        );
      }
    } catch (e) {
      if (e is APIValidationFailException) {
        rethrow; // Let the caller handle this error
      }
      throw CustomException(
        'Fetching Tasks Failed',
        message: e.toString(),
      );
    }
  }
}
