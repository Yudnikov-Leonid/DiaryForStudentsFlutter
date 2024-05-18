import 'package:dio/dio.dart';
import 'package:edu_diary/core/constants/constants.dart';
import 'package:edu_diary/features/performance/data/models/lesson.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part 'performance_api_service.g.dart';

@RestApi(baseUrl: performanceURL)
abstract class PerformanceApiService {
  factory PerformanceApiService(Dio dio) = _PerformanceApiService;

  @POST('/marksbyperiod')
  Future<HttpResponse<List<LessonModel>>> getLessons({
    @Query('apikey') String ? apikey,
    @Query('guid') String ? guid,
    @Query('from') String ? from,
    @Query('to') String? to,
  });
}