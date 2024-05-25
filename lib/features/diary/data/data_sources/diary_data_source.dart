import 'dart:convert';

import 'package:edu_diary/core/constants/constants.dart';
import 'package:edu_diary/features/diary/data/models/response.dart';
import 'package:http/http.dart' as http;

class DiaryDataSource {

  Future<DiaryResponse> getDayLessons(String date) async {
    final body = json.encode({
      'date': date,
      'apikey': 'SRJTDhppUiI',
      'guid': 'F5977F73563B57B9636658A3AC62597C',
      'pdakey': ''
    });

    final response = await http.post(Uri.parse(diaryURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
    final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 && responseJson['success']) {
      return DiaryResponse.fromJson(responseJson, date);
    } else {
      throw Exception(responseJson['message']);
    }
  }
}
