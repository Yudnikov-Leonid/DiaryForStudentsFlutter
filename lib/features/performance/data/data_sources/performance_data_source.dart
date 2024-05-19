import 'dart:convert';

import 'package:edu_diary/core/constants/constants.dart';
import 'package:edu_diary/features/performance/data/models/final_response.dart';
import 'package:edu_diary/features/performance/data/models/response.dart';
import 'package:http/http.dart' as http;

class PerformanceDataSource {

  Future<PerformanceFinalResponse> getFinalLessons() async {
    final body = json.encode({
      'apikey': 'SRJTDhppUiI',
      'guid': 'F5977F73563B57B9636658A3AC62597C',
      'pdakey': ''
    });

    final response = await http.post(Uri.parse(finalPerformanceURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
    final Map<String, dynamic> responseJson =
        jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 && responseJson['success']) {
      return PerformanceFinalResponse.fromJson(responseJson);
    } else {
      throw Exception(responseJson['message']);
    }
  }

  Future<PerformanceResponse> getLessons((String, String) period, Map<String, double> averages) async {
    final body = json.encode({
      'apikey': 'SRJTDhppUiI',
      'guid': 'F5977F73563B57B9636658A3AC62597C',
      'from': period.$1,
      'to': period.$2,
      'pdakey': ''
    });

    final response = await http.post(Uri.parse(performanceURL),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
    final responseJson = jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 && responseJson['success']) {
      return PerformanceResponse.fromJson(responseJson, averages);
    } else {
      throw Exception(responseJson['message']);
    }
  }

  Future<List<(String, String)>> getPeriods() async {
    final body = json.encode({
      'apikey': 'SRJTDhppUiI',
      'guid': 'F5977F73563B57B9636658A3AC62597C',
      'pdakey': ''
    });
    final response =
        await http.post(Uri.parse(periodsURL),
            headers: {
              'Content-Type': 'application/json',
            },
            body: body);
    final Map<String, dynamic> responseJson =
        jsonDecode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200 && responseJson['success']) {
      return (responseJson['data'] as List<dynamic>)
          .map<(String, String)>(
              (period) => (period['DATE_BEGIN'], period['DATE_END']))
          .toList();
    } else {
      throw Exception(responseJson['message']);
    }
  }
}
