import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mvvm_app_using_providers/users_list/models/users_list_model.dart';
import 'package:mvvm_app_using_providers/utils/constants.dart';

import 'api_status.dart';

class UserServices {
  static Future<Object> getUsers() async {
    try {
      final url = Uri.parse(userListUrl);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Success(
            code: 200, response: usersListModelFromJson(response.body));
      }
      return Failure(code: 100, errorResponse: 'Invalid response');
      throw HttpException('Loading error ${response.statusCode}');
    } on Exception catch (e) {
      throw const HttpException('Loading data error');
    }
  }
}
