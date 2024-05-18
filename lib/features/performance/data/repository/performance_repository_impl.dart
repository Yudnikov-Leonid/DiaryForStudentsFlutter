import 'dart:io';

import 'package:dio/dio.dart';
import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/data/data_sources/performance_api_service.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';
import 'package:edu_diary/features/performance/domain/repository/performance_repository.dart';

class PerformanceRepositoryImpl implements PerformanceRepository {
  final PerformanceApiService _performanceApiService;
  PerformanceRepositoryImpl(this._performanceApiService);

  @override
  Future<DataState<List<LessonModel>>> getLessons() async {
    try {
      final httpResponse = await _performanceApiService.getLessons(
          apikey: 'SRJTDhppUiI',
          guid: 'F5977F73563B57B9636658A3AC62597C',
          from: '06.11.2023',
          to: '29.12.2023');

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.response.data['data']
            .map((e) => LessonModel.fromJson(e)));
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
