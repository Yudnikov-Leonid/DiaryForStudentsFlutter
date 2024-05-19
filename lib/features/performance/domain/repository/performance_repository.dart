import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';

abstract class PerformanceRepository {
  Future<DataState<(List<LessonEntity>, int)>> getLessons();
  Future<DataState<List<LessonEntity>>> changeQuarter(int newQuarter);
  int currentQuarter();
}