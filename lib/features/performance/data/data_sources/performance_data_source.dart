import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/data/models/pesponse.dart';
import 'package:http/http.dart' as http;

class PerformanceDataSource {
  final Dio _dio;
  PerformanceDataSource(this._dio);

  Future<PerformanceResponse> getLessons() async {
    final body = json.encode({
      'apikey': 'SRJTDhppUiI',
      'guid': 'F5977F73563B57B9636658A3AC62597C',
      'from': '06.11.2023',
      'to': '29.12.2023',
      'pdakey': ''
    });

    final response =
        await http.post(Uri.parse('https://mp.43edu.ru/journals/marksbyperiod'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: body);
    final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 && responseJson['success']) {
      return PerformanceResponse.fromJson(responseJson, {});
    } else {
      throw DioException(requestOptions: RequestOptions());
    }
  }
}
