import 'dart:convert';
import 'package:app_task/src/core/exceptions.dart';

import 'package:app_task/src/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<Map<String, dynamic>>> fetchTaskList() async {
    try {
      var url = Uri.parse("https://jsonplaceholder.typicode.com/todos");
      final response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData.map((e) => e as Map<String, dynamic>).toList(); // Explicit cast
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

  // Future<Object> fetchTaskList() async {
  //   Map<String, dynamic> responseVal = {};
  //   try {
  //     var url =
  //         Uri.parse("https://jsonplaceholder.typicode.com/todos");
  //     final response =
  //         await http.get(url, headers: {"Content-Type": "application/json"});
  //     final List<dynamic> jsonData = jsonDecode(response.body);
  //     // return jsonData.cast<Map<String, dynamic>>();
  //     if (response.statusCode == 200) {
  //       return responseVal;
  //     } else if (response.statusCode == 400) {
  //       throw APIValidationFailException(
  //         message: toString(responseVal),
  //       );
  //     }
  //   } catch (e) {
  //     if (e is APIValidationFailException) {
  //       rethrow;
  //     }
  //     throw CustomException(
  //       'Login Failed.',
  //       message: e.toString(),
  //     );
  //   }
  //   return responseVal;
  // }
}
