import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';

abstract class PerformanceRepository {
  Future<DataState<(List<LessonEntity> list, int quarter, (int, int) settings)>> getLessons();
  DataState<List<FinalLessonEntity>> getFinalLessons();
  Future<DataState<(List<LessonEntity> list, (int, int) settings)>> changeQuarter(int newQuarter);
  int currentQuarter();
}