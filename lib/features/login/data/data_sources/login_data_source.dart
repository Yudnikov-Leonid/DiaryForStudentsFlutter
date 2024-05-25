import 'dart:convert';

import 'package:edu_diary/core/constants/constants.dart';
import 'package:edu_diary/features/login/data/models/response.dart';
import 'package:http/http.dart' as http;

class LoginDataSource {
  
  Future<LoginResponse> login(String login, String password) async {
    final body = json.encode({
      'api_key': '3F7G8I2JHGHJ3rrhskjm094321bqWRRolp3510u9',
      'login': login,
      'password': password
    });

    final response = await http.post(Uri.parse(loginURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
    final Map<String, dynamic> responseJson =
        jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 && responseJson['success']) {
      return LoginResponse.fromJson(responseJson);
    } else {
      throw Exception(responseJson['message']);
    }
  }
}
