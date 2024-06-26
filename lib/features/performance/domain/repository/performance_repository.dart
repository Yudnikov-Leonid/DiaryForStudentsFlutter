import 'package:edu_diary/core/resources/data_state.dart';
import 'package:edu_diary/features/performance/domain/entities/final_lesson.dart';
import 'package:edu_diary/features/performance/domain/entities/lesson.dart';

abstract class PerformanceRepository {
  Future<int> init();
  Future<DataState<(List<LessonEntity> list, int quarter, (int, int) settings)>> getLessons();
  Future<DataState<List<LessonEntity>>> getLessonsByQuarter(int quarter);
  DataState<List<FinalLessonEntity>> getFinalLessons();
  Future<DataState<(List<LessonEntity> list, (int, int) settings)>> changeQuarter(int newQuarter);
  int currentQuarter();
  List<(String, String)> periods();

  Future<void> changeSort(int newValue);
  Future<void> changeSortOrder(int newValue);
}